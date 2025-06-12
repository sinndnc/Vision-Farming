//
//  FarmRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import Combine

final class FarmRepositoryImpl : FarmRepository {
    
    private let local: LocalFarmDataSource
    private let remote: RemoteFarmDataSource
    private let networkMonitor: NetworkMonitor
    
    init(local: LocalFarmDataSource, remote: RemoteFarmDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(owner_id: String, policy: CachePolicy) -> AnyPublisher<[Farm], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch(owner_id: owner_id)
                .flatMap { [weak self] farms in
                    guard let self = self else {
                        return Just(farms)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    if !farms.isEmpty{
                        self.local.save(farms)
                    }
                    
                    return Just(farms)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                    
                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(_):
            Logger.log("♻️ Using staleWhileRevalidate policy on Farms")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream = local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
            
            if useRemote {
                let remoteStream = remote.fetch(owner_id: owner_id)
                    .flatMap { [weak self] farms in
                        guard let self = self else {
                            return Just(farms).setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        
                        if !farms.isEmpty{
                            self.local.save(farms)
                        }
                        return Just(farms)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localFarms -> AnyPublisher<[Farm], NetworkErrorCallback> in
                        let localPublisher = Just(localFarms)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<[Farm], NetworkErrorCallback> in
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
