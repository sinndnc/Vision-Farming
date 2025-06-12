//
//  IrrigationType.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/7/25.
//


enum IrrigationType : String, CaseIterable, SelectableItem{
    case drip
    case sprinkler
    case hose
    
    var id: String { rawValue }
    
    var displayText: String {
        rawValue
    }
}