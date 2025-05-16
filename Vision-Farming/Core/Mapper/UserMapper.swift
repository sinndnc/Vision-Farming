//
//  UserMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/3/25.
//

import Foundation
import CoreData

class UserMapper{
    
    static func toEntity(_ input: User, context: NSManagedObjectContext) {
        let userEntity = UserEntity(context: context)
        userEntity.id = input.id
        userEntity.name = input.name
        userEntity.surname = input.surname
        userEntity.image = input.image
    }
    
    static func toModel(_ input: UserEntity) -> User {
        return User(
            id: input.id ?? String(),
            name: input.name ?? String(),
            surname: input.surname ?? String(),
            email: "sinandinc7705@gmail.com" ?? String(),
            role: "admin",
            image: input.image ?? Data()
        )
    }
}
