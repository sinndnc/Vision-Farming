//
//  Sensor.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore

struct Sensor : Codable , Hashable {
    var uid : String
    var unit : String
    var name : String
    var status : String
    var type : SensorEnum
    var last_reading : Int
    var last_updated : Date?
    var owner_field : String
}
