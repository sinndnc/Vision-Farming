//
//  FirebasePublisher.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/18/25.
//

import FirebaseFirestore
import Combine

struct FirebasePublisher {
    static func listenCollection<T: Decodable>(from collection: CollectionReference, as objectType: T.Type) -> AnyPublisher<[T], Error> {
        let subject = PassthroughSubject<[T], Error>()
        
        collection.addSnapshotListener { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error))
            } else {
                let objects = snapshot?.documents.compactMap { try? $0.data(as: objectType) } ?? []
                subject.send(objects)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
}
