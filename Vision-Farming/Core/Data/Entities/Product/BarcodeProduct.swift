//
//  ProductData.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/10/25.
//


import Foundation
import CoreLocation

struct BarcodeProduct: Codable {
//    let product: Product
    let farmer: Farmer
    let cultivation: Cultivation
    let environment: BarcodeEnvironment
    let postHarvest: PostHarvest
    let qualityTests: QualityTests
    let sales: Sales
    let traceability: Traceability
}

//struct Product: Codable {
//    let name: String
//    let variety: String
//    let batchID: String
//    let harvestDate: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name, variety
//        case batchID = "batch_id"
//        case harvestDate = "harvest_date"
//    }
//}

struct Farmer: Codable {
    let name: String
    let location: Location
    let certifications: [String]
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let region: String
}

struct Cultivation: Codable {
    let seed: Seed
    let plantingDate: String
    let fertilization: [Fertilization]
    let pesticides: [Pesticide]
    
    enum CodingKeys: String, CodingKey {
        case seed
        case plantingDate = "planting_date"
        case fertilization, pesticides
    }
}

struct Seed: Codable {
    let brand: String
    let gmo: Bool
}


struct Pesticide: Codable {
    let name: String
    let date: String
    let organic: Bool
}

struct BarcodeEnvironment: Codable {
    let soilPH: Double
    let temperatureAvgC: Double
    let humidityAvgPercent: Double
    let irrigationMethod: String
    
    enum CodingKeys: String, CodingKey {
        case soilPH = "soil_ph"
        case temperatureAvgC = "temperature_avg_c"
        case humidityAvgPercent = "humidity_avg_percent"
        case irrigationMethod = "irrigation_method"
    }
}

struct PostHarvest: Codable {
    let processing: String
    let storage: String
    let transport: Transport
}

struct Transport: Codable {
    let logisticsCompany: String
    let temperatureControlled: Bool
    
    enum CodingKeys: String, CodingKey {
        case logisticsCompany = "logistics_company"
        case temperatureControlled = "temperature_controlled"
    }
}

struct QualityTests: Codable {
    let pesticideResidue: String
    let microbiological: String
    let certified: Bool
    
    enum CodingKeys: String, CodingKey {
        case pesticideResidue = "pesticide_residue"
        case microbiological, certified
    }
}

struct Sales: Codable {
    let market: String
    let shelfDate: String
    let expiryDate: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case shelfDate = "shelf_date"
        case expiryDate = "expiry_date"
    }
}

struct Traceability: Codable {
    let blockchainID: String
    let verified: Bool
    
    enum CodingKeys: String, CodingKey {
        case blockchainID = "blockchain_id"
        case verified
    }
}
