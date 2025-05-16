//
//  RemoteFieldDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import FirebaseFirestore
import Foundation
import Combine

final class RemoteFieldDataSourceImpl : RemoteFieldDataSource{
    
    private let firestore : Firestore
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore : Firestore) {
        self.firestore = firestore
    }
    
    func fetch(owner_farm: String) -> AnyPublisher<[Field], any Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.fields)
                .whereField(FirebaseConstant.owner_farm, isEqualTo: owner_farm)
                .addSnapshotListener { [weak self] snapshot, error in
                    
                    if let error = error { promise(.failure(error))}
                    
                    let fields = snapshot?.documents.compactMap { try? $0.data(as: Field.self) } ?? []
                    
                    promise(.success(fields))
                }
        }
        .eraseToAnyPublisher()
    }
}
