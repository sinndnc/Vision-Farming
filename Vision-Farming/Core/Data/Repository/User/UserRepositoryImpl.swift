//
//  UserRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Foundation
import Combine

final class UserRepositoryImpl : UserRepository {
    
    private let local: LocalUserDataSource
    private let remote: RemoteUserDataSource
    private let networkMonitor: NetworkMonitor
    
    init(local: LocalUserDataSource, remote: RemoteUserDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(policy: CachePolicy) -> AnyPublisher<User?, NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .map { Optional($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch()
                .handleEvents(receiveOutput: { user in
                    Logger.log("🌐 Remote verisi alındı, lokal cache güncelleniyor...")
                    self.local.save(user)
                })
                .mapError { NetworkErrorCallback.remote($0) }
                .map { Optional($0) }
                .eraseToAnyPublisher()

        case .staleWhileRevalidate(let ttl):
            Logger.log("♻️ Using staleWhileRevalidate policy on Users")
            
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream = local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .map { Optional($0) }
                .catch { error -> AnyPublisher<User?, NetworkErrorCallback> in
                    Logger.log("🛑 Lokal veri bulunamadı, `nil` döndürülecek.")
                    return Just(nil)
                        .setFailureType(to: NetworkErrorCallback.self)
                        .eraseToAnyPublisher()
                }
            
            if useRemote {
                let remoteStream = remote.fetch()
                    .handleEvents(receiveOutput: { user in
                        Logger.log("🌐 Remote verisi alındı, lokal cache güncelleniyor...")
                        if user.id != nil {
                            self.local.save(user)
                        }
                    })
                    .mapError { NetworkErrorCallback.remote($0) }
                    .map { Optional($0) }
                
                return localStream
                    .flatMap { localUser -> AnyPublisher<User?, NetworkErrorCallback> in
                        let localPublisher = Just(localUser)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<User?, NetworkErrorCallback> in
                                Logger.log("⚠️ Remote fetch failed: \(error)")
                                return .init()
                            }
                            .eraseToAnyPublisher()
                        
                        if localUser == nil {
                            Logger.log("Local User is nil,just return remote")
                            return remotePublisher
                                .eraseToAnyPublisher()
                        }else{
                            Logger.log("Local User is not nil,append remote")
                            return localPublisher
                                .append(remotePublisher)
                                .eraseToAnyPublisher()
                        }
                    }
                    .eraseToAnyPublisher()
            } else {
                Logger.log("📦 Using only cached data (no internet or fresh cache)")
                return localStream.eraseToAnyPublisher()
            }
        }
    }
    
}
