//
//  RemoteSensorDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import FirebaseFirestore
import Foundation
import Combine

final class RemoteSensorDataSourceImpl: RemoteSensorDataSource {
    
    private let firestore : Firestore
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore : Firestore) {
        self.firestore = firestore
    }
    
    func fetch(owner_field: String) -> AnyPublisher<[Sensor], any Error> {
        let sensorsPublisher = Future<[Sensor], Error> { promise in
            self.firestore
                .collection(FirebaseConstant.sensors)
                .whereField(FirebaseConstant.owner_field, isEqualTo: owner_field)
                .addSnapshotListener { snapshot, error in
                    if let error = error { promise(.failure(error))}
                    let sensors = snapshot?.documents.compactMap { try? $0.data(as: Sensor.self) } ?? []
                    promise(.success(sensors))
                }
        }
        return sensorsPublisher
            .flatMap { sensors -> AnyPublisher<[Sensor], Error> in
                let historyPublishers = sensors.map { sensor in
                    self.history(sensor_id: sensor.id ?? "")
                        .map { history -> Sensor in
                            var updatedSensor = sensor
                            updatedSensor.history = history
                            return updatedSensor
                        }
                        .eraseToAnyPublisher()
                }
                
                return Publishers.MergeMany(historyPublishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func history(sensor_id: String) -> AnyPublisher<[SensorHistory], Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.sensors)
                .document(sensor_id)
                .collection(FirebaseConstant.history)
                .addSnapshotListener { snapshot, error in
                    if let error = error { promise(.failure(error))}
                    let history = snapshot?.documents.compactMap { try? $0.data(as: SensorHistory.self) } ?? []
                    promise(.success(history))
                }
        }
        .eraseToAnyPublisher()
    }
}
