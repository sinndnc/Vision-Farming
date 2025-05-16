//
//  CropMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/28/25.
//

import FirebaseFirestore
import Foundation
import CoreData

class CropMapper{
    
    static func toEntity(_ input: Crop, context: NSManagedObjectContext) {
        let cropEntity = CropEntity(context: context)
        cropEntity.id = input.id
        cropEntity.name = input.name
        cropEntity.owner_id = input.owner_id
        cropEntity.expected_harvest_date = input.expected_harvest_date
        cropEntity.image = input.image
        cropEntity.notes = input.notes
        cropEntity.planted_date = input.planted_date
        cropEntity.setValue(input.coordinates, forKey: "coordinates")
    }
    
    static func toModel(_ input: CropEntity) -> Crop {
        return Crop(
            id: input.id ?? String(),
            name: input.name ?? String(),
            image: input.image ?? Data(),
            notes: input.notes ?? String(),
            owner_id: input.owner_id ?? String(),
            planted_date: input.planted_date ?? Date(),
            coordinates: input.value(forKey: "coordinates") as? [GeoPoint] ?? [],
            expected_harvest_date: input.expected_harvest_date ?? Date()
        )
    }
}
