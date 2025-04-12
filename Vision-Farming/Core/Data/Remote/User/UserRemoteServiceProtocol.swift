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
    
    func fetchUser(of uid: String) async throws ->  Result<UserDTO,UserErrorCallback>
    
    func fetchFarms(of owner_uid: String) async throws -> Result<[Farm], UserErrorCallback>
    
    func fetchFields(of owner_farm: String) async throws -> Result<[Field], UserErrorCallback>
    
    func fetchSensors(of owner_field: String) async throws -> Result<[Sensor], UserErrorCallback>

}
