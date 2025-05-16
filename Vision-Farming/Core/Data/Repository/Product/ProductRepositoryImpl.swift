//
//  ProductRepositoryProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import Foundation
import Combine

final class ProductRepositoryImpl : ProductRepository{
    
    private let remote: RemoteProductDataSource
    private let networkMonitor: NetworkMonitor
    
    init(remote: RemoteProductDataSource, networkMonitor: NetworkMonitor) {
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(policy: CachePolicy) -> AnyPublisher<[MarketProduct], NetworkErrorCallback> {
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
                .flatMap { [weak self] products in
                    guard let self = self else {
                        return Just(products)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    //                    self.local.save(products)
                    
                    return Just(products)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                    
                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(let ttl):
            Logger.log("♻️ Using staleWhileRevalidate policy on Crops")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            if useRemote {
                let remotePublisher =  remote.fetch()
                    .catch { error -> Empty<[MarketProduct], NetworkErrorCallback> in
                        Logger.log("⚠️ Remote fetch failed: \(error.localizedDescription)")
                        return .init()
                    }
                    .eraseToAnyPublisher()
                
                return remotePublisher
                    .eraseToAnyPublisher()
            }else{
                return Just([])
                    .setFailureType(to: NetworkErrorCallback.self)
                    .eraseToAnyPublisher()
            }
        }
    }
    
}
