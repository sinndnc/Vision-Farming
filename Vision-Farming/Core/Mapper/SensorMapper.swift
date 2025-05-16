//
//  SensorMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import CoreData

class SensorMapper{
    
    static func toEntity(_ input: Sensor, context: NSManagedObjectContext){
        let sensorEntity = SensorEntity(context: context)
        sensorEntity.id = input.id
        sensorEntity.name = input.name
        sensorEntity.owner_field = input.owner_field
        sensorEntity.last_reading =  Int64(input.last_reading ?? 0)
        sensorEntity.last_updated = input.last_updated
        sensorEntity.status = input.status
        sensorEntity.type = input.type.rawValue
        sensorEntity.unit = input.unit
      
    }
    
    static func toModel(_ input: SensorEntity) -> Sensor {
        return Sensor(
            id: input.id,
            unit: input.unit ?? String(),
            name: input.name ?? String(),
            status: input.status ?? String(),
            type: SensorEnum(rawValue: input.type ?? String()) ?? .airMoisture,
            last_reading: Int(input.last_reading),
            last_updated: input.last_updated ?? Date(),
            owner_field: input.owner_field ?? String(),
        )
    }
}
