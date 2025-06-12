//
//  SensorEnum.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//


enum SensorEnum: String, Codable ,CaseIterable {
    case temperature
    case humidity
    case soilPh
    case airMoisture
    case soilMoisture
    case airQuality
    
}

extension SensorEnum{
    
    var toString : String{
        return switch self {
        case .airMoisture:
            "Air Moisture"
        case .airQuality:
            "Air Quality"
        case .humidity:
            "Humidity"
        case .soilMoisture:
            "Soil Moisture"
        case .soilPh:
            "Soil pH"
        case .temperature:
            "Temperature"
        }
    }
    
    var toUnit : String{
        return switch self {
        case .airMoisture:
            "%"
        case .airQuality:
            "ppm"
        case .humidity:
            "%"
        case .soilMoisture:
            "%"
        case .soilPh:
            "-"
        case .temperature:
            "°C"
        }
    }
}
