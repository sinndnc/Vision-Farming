//
//  FieldMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/29/25.
//

import FirebaseFirestore
import Foundation
import CoreData

class FieldMapper{
    
    static func toEntity(_ input: Field, context: NSManagedObjectContext){
        let fieldEntity = FieldEntity(context: context)
        fieldEntity.id = input.id
        fieldEntity.name = input.name
        fieldEntity.owner_farm = input.owner_farm
        fieldEntity.harvest_date = input.harvest_date
        fieldEntity.planted_date = input.planted_date
        fieldEntity.setValue(input.coordinates, forKey: "coordinates")
    }
    
    static func toModel(_ input: FieldEntity) -> Field {
        return Field(
            id: input.id,
            name: input.name ?? String(),
            owner_farm: input.owner_farm ?? String(),
            coordinates: input.value(forKey: "coordinates") as? [GeoPoint] ?? [],
            harvest_date: input.harvest_date ?? Date(),
            planted_date: input.planted_date ?? Date()
        )
    }
}
