//
//  UserRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation

final class UserRepository : UserRepositoryProtocol{
    
    @Inject private var userRemoteService : UserRemoteServiceProtocol
    
    var isLogged : Bool { return userRemoteService.isLogged }
    
    func fetch() async -> Result<User,UserErrorCallback> {
        do{
            let uid = "QNpNMfg4fGd9njQljZZdEeKgesT2"
            let result = try await userRemoteService.fetchUser(of: uid)
            switch(result){
            case .success(let userDto):
                var user = User(dto: userDto)
                
                let farms = try await userRemoteService.fetchFarms(of: user.uid).get()
                user.farms = farms
                
                for farm in farms {
                    let fields = try await userRemoteService.fetchFields(of: farm.uid).get()
                    user.fields[farm] = fields
                    
                    for field in fields {
                        let sensors = try await userRemoteService.fetchSensors(of: field.uid).get()
                        user.sensors[field] = sensors
                    }
                }
                return .success(user)
            case .failure(let error):
                return .failure(error)
            }
        }
        catch {
            return .failure(.noConnection)
        }
    }
}
