//
//  RemoteUserDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Combine
import Supabase
import Foundation
import FirebaseAuth
import FirebaseFirestore


final class RemoteUserDataSourceImpl : RemoteUserDataSource{
    
    private let auth : Auth
    private let storage : StorageService
    private let firestore : Firestore
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore : Firestore,storage: StorageService,auth : Auth) {
        self.auth = auth
        self.storage = storage
        self.firestore = firestore
    }
    
    func fetch() -> AnyPublisher<User, NetworkErrorCallback> {
        let subject = PassthroughSubject<User, NetworkErrorCallback>()
        
        guard let user = auth.currentUser else {
            Logger.log("NO CURRENT USER")
            subject.send(completion: .finished)
            return subject.eraseToAnyPublisher()
        }
        
        firestore
            .collection(FirebaseConstant.users)
            .document(user.uid)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    Logger.log("🔥 Firestore error: \(error.localizedDescription)")
                    subject.send(completion: .failure(.remote(error)))
                    return
                }
                
                guard let snapshot = snapshot,
                      var user = try? snapshot.data(as: User.self) else {
                    Logger.log("❌ Snapshot parse edilemedi veya boş geldi.")
                    subject.send(completion: .finished)
                    return
                }
                
                self.storage.downloadImage(subPath: "users", path: user.id!)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            Logger.log("🛑 Image download error: \(error)")
                        }
                    }, receiveValue: { image in
                        user.image = image
                        subject.send(user)
                    })
                    .store(in: &self.cancellable)
            }
        
        return subject.eraseToAnyPublisher()
    }

}
