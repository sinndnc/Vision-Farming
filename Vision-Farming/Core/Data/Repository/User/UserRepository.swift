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
    
    func fetch() async -> Result<User?,UserErrorCallback> {
        do{
            let result = try await userRemoteService.fetch()
            switch(result){
            case .success(let user):
                return .success(user)
            case .failure(let error):
                print(error)
                return .failure(error)
            }
        }
        catch {
            print(error)
            return .failure(.noConnection)
        }
    }
    
    
}
