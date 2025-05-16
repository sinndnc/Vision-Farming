//
//  FarmMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import CoreData
import FirebaseFirestore

class FarmMapper{
    
    static func toEntity(_ input: Farm, context: NSManagedObjectContext) {
        let farmEntity = FarmEntity(context: context)
        farmEntity.id = input.id
        farmEntity.name = input.name
        farmEntity.owner_id = input.owner_id
        farmEntity.latitude = input.location.latitude
        farmEntity.longitude = input.location.longitude
    }
    
    static func toModel(_ input: FarmEntity) -> Farm {
        return Farm(
            id: input.id ?? String(),
            name: input.name ?? String(),
            owner_id: input.owner_id ?? String(),
            location: GeoPoint(latitude: input.latitude, longitude: input.longitude)
        )
    }
}
