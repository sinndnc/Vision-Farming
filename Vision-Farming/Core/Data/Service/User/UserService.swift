//
//  UserRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseFirestore

final class UserService {
    
    private let db : Firestore
    private let auth : FirebaseAuth.Auth
    private var listener: ListenerRegistration?
    public let userSubject = CurrentValueSubject<User?, Never>(nil)
    
    
    init(auth: FirebaseAuth.Auth,firestore: Firestore) {
        self.auth = auth
        self.db = firestore
    }
    
    func startListening() {
        guard let currentUser = auth.currentUser else { return }
        listener = db.collection(FirebaseConstant.users)
            .document(currentUser.uid)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let user = try? snapshot?.data(as: User.self) {
                    self.userSubject.send(user)
                }
            }
    }
    
    func stopListening() {
        listener?.remove()
    }
    
    deinit {
        listener?.remove()
    }

}
