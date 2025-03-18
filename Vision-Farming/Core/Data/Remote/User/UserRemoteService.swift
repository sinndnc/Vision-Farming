//
//  UserRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class UserRemoteService : UserRemoteServiceProtocol{
    
    let firestore: Firestore
    let auth : FirebaseAuth.Auth
    
    var isLogged : Bool { return auth.currentUser != nil }
    
    init(auth: FirebaseAuth.Auth,firestore: Firestore) {
        self.auth = auth
        self.firestore = firestore
    }
    
    func fetch() async throws -> Result<User,UserErrorCallback> {
        
        try await auth.signIn(withEmail: "sinandinc77@icloud.com", password: "Snn20012004")
        guard let auth = auth.currentUser else { throw UserErrorCallback.invalidUser }
        
        do{
            let reference = firestore.collection(FirebaseConstant.users).document(auth.uid)
            let user = try await reference.getDocument().data(as: User.self)
            
            return .success(user)
        }
        catch{
            return .failure(.noConnection)
        }
        
    }
}
