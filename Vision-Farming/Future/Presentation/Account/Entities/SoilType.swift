//
//  SoilType.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/7/25.
//


enum SoilType : String, CaseIterable, SelectableItem{
    case clayey
    case sandy
    case loamy
    
    var id: String { rawValue }
    
    var displayText: String {
        rawValue
    }
}

