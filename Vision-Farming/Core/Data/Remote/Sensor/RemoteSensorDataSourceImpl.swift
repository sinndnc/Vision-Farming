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
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.sensors)
                .whereField(FirebaseConstant.owner_field, isEqualTo: owner_field)
                .addSnapshotListener { [weak self] snapshot, error in
                    
                    if let error = error { promise(.failure(error))}
                    
                    let sensors = snapshot?.documents.compactMap { try? $0.data(as: Sensor.self) } ?? []
                    
                    promise(.success(sensors))
                }
        }
        .eraseToAnyPublisher()
    }
}
