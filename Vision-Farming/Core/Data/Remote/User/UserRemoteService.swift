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
    
    func fetchUser(of uid: String) async throws -> Result<UserDTO, UserErrorCallback> {
        
        guard let auth = auth.currentUser else { throw UserErrorCallback.invalidUser }
        
        do{
            let reference = firestore.collection(FirebaseConstant.users).document(auth.uid)
            let user = try await reference.getDocument().data(as: UserDTO.self)
            
            return .success(user)
        }
        catch{
            return .failure(.noConnection)
        }
    }
    
    func fetchFarms(of owner_uid: String) async throws -> Result<[Farm], UserErrorCallback> {
        do{
            var farms : [Farm] = []
            let reference = try await firestore.collection(FirebaseConstant.farms)
                .whereField("owner_uid", isEqualTo: owner_uid)
                .getDocuments()
            
            for document in reference.documents{
                let farm = try document.data(as: Farm.self)
                farms.append(farm)
            }
            
            return .success(farms)
        }
        catch{
            return .failure(.invalidUser)
        }
    }
    
    func fetchFields(of owner_farm: String) async throws -> Result<[Field], UserErrorCallback> {
        do{
            var fields : [Field] = []
            let reference = try await firestore.collection(FirebaseConstant.fields)
                .whereField("owner_farm", isEqualTo: owner_farm)
                .getDocuments()
            
            for document in reference.documents{
                let field = try document.data(as: Field.self)
                fields.append(field)
            }
            
            return .success(fields)
        }
        catch{
            return .failure(.noConnection)
        }
    }
    
    
    func fetchSensors(of owner_field: String) async throws -> Result<[Sensor], UserErrorCallback> {
        do{
            var sensors: [Sensor] = []
            let reference = try await firestore.collection(FirebaseConstant.sensors)
                .whereField("owner_field", isEqualTo: owner_field)
                .getDocuments()
            
            for document in reference.documents {
                let sensor = try document.data(as: Sensor.self)
                sensors.append(sensor)
            }
            
            return .success(sensors)
        }
        catch{
            return .failure(.noConnection)
        }
    }
 
}
