//
//  TransactionRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Foundation
import Combine


final class TransactionRepositoryImpl : TransactionRepository {
    
    private let remote: RemoteTransactionDataSource
    private let networkMonitor: NetworkMonitor
    
    init( remote: RemoteTransactionDataSource, networkMonitor: NetworkMonitor) {
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(for owner_id: String, policy: CachePolicy) -> AnyPublisher<[Transaction], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return Just([])
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.getTransactions(for: owner_id)
                .flatMap { [weak self] transactions in
                    guard let self = self else {
                        return Just(transactions)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    if !transactions.isEmpty{
//                        self.local.save(fields)
                    }
                    
                    return Just(transactions)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                    
                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(_):
            Logger.log("♻️ Using staleWhileRevalidate policy on Fields")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream : Result<[Transaction], NetworkErrorCallback>.Publisher = Just([])
                .mapError { NetworkErrorCallback.local($0) }
            
            if useRemote {
                let remoteStream = remote.getTransactions(for: owner_id)
                    .flatMap { [weak self] transactions in
                        guard let self = self else {
                            return Just(transactions).setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        if !transactions.isEmpty{
//                            self.local.save(fields)
                        }
                        return Just(transactions)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localTransaction -> AnyPublisher<[Transaction], NetworkErrorCallback> in
                        let localPublisher = Just(localTransaction)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        let remotePublisher = remoteStream
                            .catch { error -> Empty<[Transaction], NetworkErrorCallback> in
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
