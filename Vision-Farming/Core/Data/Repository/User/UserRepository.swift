//
//  UserRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import Combine

final class UserRepository {
    
    private let userService : UserService
    
    @Published var user : User?
    
    init() {
        self.userService = UserService(auth: .auth(), firestore: .firestore())
    }
    
    var userPublisher: AnyPublisher<User?, Never> {
        userService.userSubject.eraseToAnyPublisher()
    }
    
    func start() {
        userService.startListening()
    }
    
    func stop(){
        userService.stopListening()
    }
  
}
