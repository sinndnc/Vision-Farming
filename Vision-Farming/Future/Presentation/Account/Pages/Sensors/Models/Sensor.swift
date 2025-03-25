//
//  Sensors.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/25/25.
//

import Foundation

enum SensorType: String, Codable {
    case temperature = "Temperature"
    case humidity = "Humidity"
    case soilPh = "Soil pH"
    case airMoisture = "Air Moisture"
    case soilMoisture = "Soil Moisture"
    case airQuality = "Air Quality"
    
}

struct Sensor: Identifiable, Codable {
    var id: String
    var name: String
    var type: SensorType
    var unit: String
    var value: Double
    var isActive: Bool
    var lastUpdated: Date
}
