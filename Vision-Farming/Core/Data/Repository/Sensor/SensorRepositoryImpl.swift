//
//  SensorRepositoryImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Combine


final class SensorRepositoryImpl : SensorRepository{
    
    private let local: LocalSensorDataSource
    private let remote: RemoteSensorDataSource
    private let networkMonitor: NetworkMonitor
    
    init(local: LocalSensorDataSource, remote: RemoteSensorDataSource, networkMonitor: NetworkMonitor) {
        self.local = local
        self.remote = remote
        self.networkMonitor = networkMonitor
    }
    
    func listen(owner_field: String, policy: CachePolicy) -> AnyPublisher<[Sensor], NetworkErrorCallback> {
        switch policy {
        case .localOnly:
            Logger.log("⛺️ Using localOnly policy")
            return local.fetch()
                .mapError { NetworkErrorCallback.local($0) }
                .eraseToAnyPublisher()
            
        case .networkOnly:
            Logger.log("🌐 Using networkOnly policy")
            return remote.fetch(owner_field: owner_field)
                .flatMap { [weak self] sensors in
                    guard let self = self else {
                        return Just(sensors)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    if !sensors.isEmpty{
                        self.local.save(sensors)
                    }
                    return Just(sensors)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                    
                }
                .mapError { NetworkErrorCallback.remote($0) }
                .eraseToAnyPublisher()
            
        case .staleWhileRevalidate(_):
            Logger.log("♻️ Using staleWhileRevalidate policy on Sensors")
            let useRemote = networkMonitor.isConnected/* && local.isCacheExpired(ttl: ttl)*/
            
            let localStream = local.fetch()
                .map{ return Array(Set($0)) }
                .mapError { NetworkErrorCallback.local($0) }
            
            if useRemote {
                let remoteStream = remote.fetch(owner_field: owner_field)
                    .flatMap { [weak self] sensors in
                        guard let self = self else {
                            return Just(sensors).setFailureType(to: Error.self).eraseToAnyPublisher()
                        }
                        if !sensors.isEmpty{
                            self.local.save(sensors)
                        }
                        return Just(Array(Set(sensors)))
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .mapError { NetworkErrorCallback.remote($0) }
                
                return localStream
                    .flatMap { localSensors -> AnyPublisher<[Sensor], NetworkErrorCallback> in
                        _ = Just(localSensors)
                            .setFailureType(to: NetworkErrorCallback.self)
                            .eraseToAnyPublisher()
                        
                        _ = remoteStream
                            .catch { error -> Empty<[Sensor], NetworkErrorCallback> in
                                Logger.log("⚠️ Remote fetch failed: \(error.localizedDescription)")
                                return .init()
                            }
                            .eraseToAnyPublisher()
                        
                        return localStream
                               .append(remoteStream)
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
