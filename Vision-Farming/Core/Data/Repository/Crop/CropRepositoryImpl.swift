//
//  ProductRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//

import Foundation
import Combine

final class CropRepositoryImpl: CropRepository {
    
    private let local: LocalCropDataSource
    private let remote: RemoteCropDataSource
    private let networkMonitor: NetworkMonitor
    
    init(local: LocalCropDataSource, remote: RemoteCropDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(owner_id: String, policy: CachePolicy) -> AnyPublisher<[Crop], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch(owner_id: owner_id)
                .flatMap { [weak self] crops in
                    guard let self = self else {
                        return Just(crops)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    self.local.save(crops)
                        
                    return Just(crops)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()

                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(_):
            Logger.log("♻️ Using staleWhileRevalidate policy on Crops")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream = local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
            
            if useRemote {
                let remoteStream = remote.fetch(owner_id: owner_id)
                    .flatMap { [weak self] crops in
                        guard let self = self else {
                            return Just(crops).setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        if !crops.isEmpty{
                            self.local.save(crops)
                        }
                        return Just(crops)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localCrops -> AnyPublisher<[Crop], NetworkErrorCallback> in
                        let localPublisher = Just(localCrops)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<[Crop], NetworkErrorCallback> in
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
    
    
    func add(_ crop: Crop) {
        remote.add(crop)
    }
}
