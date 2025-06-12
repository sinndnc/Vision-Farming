//
//  RemoteTransactionDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Combine
import FirebaseFirestore

final class RemoteTransactionDataSourceImpl : RemoteTransactionDataSource{
    
    private let firestore : Firestore
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore: Firestore) {
        self.firestore = firestore
    }
    
    func getTransactions(for owner_id: String) -> AnyPublisher<[Transaction], any Error> {
        Future{ promise in
            self.firestore.collection(FirebaseConstant.transactions)
                .whereField(FirebaseConstant.owner_id, isEqualTo: owner_id)
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    
                    let transactions = snapshot?.documents.compactMap {
                        try? $0.data(as: Transaction.self)
                    } ?? []
                    
                    
                    promise(.success(transactions))
                }
        }
        .eraseToAnyPublisher()
    }
    
    
    
    
}
