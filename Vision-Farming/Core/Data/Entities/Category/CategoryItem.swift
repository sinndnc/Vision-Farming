//
//  LeafyVegetables.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/20/25.
//

import Foundation

class CategoryItem: Codable, Hashable {
    var name: String
    var description: String
    var climate: Climate
    var watering: Watering
    var soil_requirements: SoilRequirements
    var fertilization: Fertilization
    var pests_diseases: PestsDiseases
    var growing_process: GrowingProcess
    var harvesting: Harvesting
    
    init(name: String, description: String, climate: Climate, watering: Watering, soil_requirements: SoilRequirements, fertilization: Fertilization, pests_diseases: PestsDiseases, growing_process: GrowingProcess, harvesting: Harvesting) {
        self.name = name
        self.description = description
        self.climate = climate
        self.watering = watering
        self.soil_requirements = soil_requirements
        self.fertilization = fertilization
        self.pests_diseases = pests_diseases
        self.growing_process = growing_process
        self.harvesting = harvesting
    }
    
    static func == (lhs: CategoryItem, rhs: CategoryItem) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}

struct Climate : Codable,Hashable {
    var min_temp: Int
    var max_temp : Int
    var sensitivity : String
    var description : String
}

struct Fertilization : Codable,Hashable {
    var type : String
    var recommended : [String]
    var description : String
}

struct GrowingProcess : Codable,Hashable {
    var maturity_days : String
    var description : String
    var seed_depth : String
    var thinning : String
}

struct Harvesting : Codable,Hashable {
    var method : String
    var description : String
    var best_period : String
}

struct PestsDiseases : Codable,Hashable {
    var common : [String]
    var description : String
}

struct SoilRequirements : Codable ,Hashable{
    var pH : String
    var description : String
    var type : String
    var organic_matter : String
}

struct Watering : Codable,Hashable {
    var frequency : String
    var description : String
    var soil_moisture : String
}

