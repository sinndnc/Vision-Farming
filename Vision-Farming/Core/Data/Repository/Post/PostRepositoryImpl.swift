//
//  PostRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/16/25.
//

import Foundation
import Combine

final class PostRepositoryImpl : PostRepository{
    
    private let remote: RemotePostDataSource
    private let networkMonitor: NetworkMonitor
    
    init(remote: RemotePostDataSource, networkMonitor: NetworkMonitor) {
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(policy: CachePolicy) -> AnyPublisher<[Post], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            //            return local.fetch()
            //                .mapError { NetworkErrorCallback.local($0) }
            //                .eraseToAnyPublisher()
            //
            return Just([])
                .setFailureType(to: NetworkErrorCallback.self)
                .eraseToAnyPublisher()
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch()
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(_):
            Logger.log("♻️ Using staleWhileRevalidate policy on Posts")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            if useRemote {
                let remotePublisher =  remote.fetch()
                    .catch { error -> Empty<[Post], NetworkErrorCallback> in
                        Logger.log("⚠️ Remote fetch failed: \(error.localizedDescription)")
                        return .init()
                    }
                    .eraseToAnyPublisher()
                
                return remotePublisher
                    .eraseToAnyPublisher()
            }else{
                return Fail<[Post], NetworkErrorCallback>(error: NetworkErrorCallback.noConnection)
                    .eraseToAnyPublisher()
            }
        }
    }
    
    
}
