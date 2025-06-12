//
//  RemoteFarmDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import FirebaseFirestore
import Foundation
import Combine

final class RemoteFarmDataSourceImpl : RemoteFarmDataSource{
    
    private let firestore : Firestore
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore : Firestore) {
        self.firestore = firestore
    }
    
    func fetch(owner_id: String) -> AnyPublisher<[Farm], any Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.farms)
                .whereField(FirebaseConstant.owner_id, isEqualTo: owner_id)
                .addSnapshotListener { snapshot, error in
                    
                    if let error = error { promise(.failure(error))}
                    
                    let farms = snapshot?.documents.compactMap { try? $0.data(as: Farm.self) } ?? []
                    
                    promise(.success(farms))
                }
        }
        .eraseToAnyPublisher()
    }
    
}
