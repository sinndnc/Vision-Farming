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
        sensorEntity.last_reading = input.last_reading ?? 0
        sensorEntity.last_updated = input.last_updated
        sensorEntity.status = input.status
        sensorEntity.type = input.type.rawValue
        sensorEntity.unit = input.unit
        
        guard let histories = input.history else { return }
        let historyEntities = histories.map { history -> SensorHistoryEntity in
            let historyEntity = SensorHistoryEntity(context: context)
            historyEntity.id = history.id
            historyEntity.value = history.value
            historyEntity.timestamp = history.timestamp
            historyEntity.sensors = sensorEntity
            return historyEntity
        }
        
        sensorEntity.addToHistory(NSSet(array: historyEntities))
    }
    
    static func toModel(_ input: SensorEntity,histories : [SensorHistory]) -> Sensor {
        return Sensor(
            id: input.id,
            unit: input.unit ?? String(),
            name: input.name ?? String(),
            status: input.status ?? String(),
            type: SensorEnum(rawValue: input.type ?? String()) ?? .airMoisture,
            last_reading: input.last_reading,
            last_updated: input.last_updated ?? Date(),
            owner_field: input.owner_field ?? String(),
            history: histories
        )
    }
    
}
