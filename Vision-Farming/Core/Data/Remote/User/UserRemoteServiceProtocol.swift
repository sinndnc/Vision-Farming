//
//  UserRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserRemoteServiceProtocol{
    
    var isLogged : Bool { get }
    
    var firestore: Firestore { get }
      
    var auth : FirebaseAuth.Auth { get }
    
    func fetch() async throws ->  Result<User,UserErrorCallback>
    
}
