//
//  CategoryRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine


class CategoryRepositoryImpl : CategoryRepository {
    let local: LocalCategoryDataSourceImpl
    let remote: RemoteCategoryDataSource
    let networkMonitor: NetworkMonitor
    
    init(local: LocalCategoryDataSourceImpl, remote: RemoteCategoryDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func getAllCategories(policy : CachePolicy) -> AnyPublisher<[Category],NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetchCategories()
                .flatMap { [weak self] categories in
                    guard let self = self else {
                        return Just(categories)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
//                    self.local.save(categories)
                        
                    return Just(categories)
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
                let remoteStream = remote.fetchCategories()
                    .flatMap { [weak self] categories in
                        guard let self = self else {
                            return Just(categories)
                                .setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        if !categories.isEmpty{
                            self.local.save(categories)
                        }
                        return Just(categories)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localCategories -> AnyPublisher<[Category], NetworkErrorCallback> in
                        let localPublisher = Just(localCategories)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<[Category], NetworkErrorCallback> in
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
    
    func getAllSubCategories(of category_id: String) -> AnyPublisher<[SubCategory],NetworkErrorCallback> {
        Future{ promise in
            
        }
        .eraseToAnyPublisher()
    }
    
}
