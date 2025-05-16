//
//  FieldRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine

final class FieldRepositoryImpl : FieldRepository{
    
    private let local: LocalFieldDataSource
    private let remote: RemoteFieldDataSource
    private let networkMonitor: NetworkMonitor
    
    init(local: LocalFieldDataSource, remote: RemoteFieldDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(owner_farm: String, policy: CachePolicy) -> AnyPublisher<[Field], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch(owner_farm: owner_farm)
                .flatMap { [weak self] fields in
                    guard let self = self else {
                        return Just(fields)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    if !fields.isEmpty{
                        self.local.save(fields)
                    }
                    
                    return Just(fields)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                    
                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(let ttl):
            Logger.log("♻️ Using staleWhileRevalidate policy on Crops")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream = local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
            
            if useRemote {
                let remoteStream = remote.fetch(owner_farm: owner_farm)
                    .flatMap { [weak self] fields in
                        guard let self = self else {
                            return Just(fields).setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        if !fields.isEmpty{
                            self.local.save(fields)
                        }
                        return Just(fields)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localFarms -> AnyPublisher<[Field], NetworkErrorCallback> in
                        let localPublisher = Just(localFarms)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<[Field], NetworkErrorCallback> in
                                Logger.log("⚠️ Remote fetch failed: \(error.localizedDescription)")
                                return .init()
                            }
                            .eraseToAnyPublisher()
                        
                        return localPublisher
                            .append(remotePublisher)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            } else {
                Logger.log("📦 Using only cached data Crop (no internet or fresh cache)")
                return localStream.eraseToAnyPublisher()
            }
        }
    }
}
