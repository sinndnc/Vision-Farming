//
//  Sensor.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore

struct Sensor : FirestoreEntity {
    @DocumentID var id : String?
    var unit : String
    var name : String
    var status : String
    var type : SensorEnum
    var last_reading : Int?
    var last_updated : Date?
    var owner_field : String
    
    
    static func addSensor(type: SensorEnum,owner_field : String) -> Sensor {
        Sensor(
            unit: type.toUnit,
            name: type.toString,
            status: "active",
            type: type,
            last_reading: 0,
            last_updated: Date(),
            owner_field:owner_field
        )
    }
}


