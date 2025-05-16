//
//  CategoryMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import CoreData
import FirebaseFirestore

class CategoryMapper{
    
    static func toEntity(_ input: Category, context: NSManagedObjectContext) {
        let categoryEntity = CategoryEntity(context: context)
        categoryEntity.id = input.id
        categoryEntity.name = input.name
        categoryEntity.image = input.image
    }
    
    static func toModel(_ input: CategoryEntity) -> Category {
        return Category(
            id: input.id ?? String(),
            name: input.name ?? String(),
            image: input.image ?? Data()
        )
    }
}
