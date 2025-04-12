//
//  UserRepositoryProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation


protocol UserRepositoryProtocol {
    
    var isLogged : Bool { get }
    
    func fetch() async -> Result<User,UserErrorCallback>
}
