//
//  SensorHistoryMapper.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/20/25.
//

import Foundation
import CoreData
import FirebaseFirestore

class SensorHistoryMapper{
    
    static func toEntity(_ input: SensorHistory, context: NSManagedObjectContext) {
        let sensorHistoryEntity = SensorHistoryEntity(context: context)
        sensorHistoryEntity.id = input.id
        sensorHistoryEntity.value = input.value
        sensorHistoryEntity.timestamp = input.timestamp
        
    }
    
    static func toModel(_ input: SensorHistoryEntity) -> SensorHistory {
        return SensorHistory(
            id: input.id ?? String(),
            value: input.value,
            timestamp: input.timestamp ?? Date()
        )
    }
}
