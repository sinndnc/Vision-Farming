//
//  Season.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//


enum Season: String, Codable, CaseIterable {
    case all
    case spring
    case summer
    case autumn
    case winter
    
    var startMonth: Int {
        switch self {
        case .spring: return 3
        case .summer: return 6
        case .autumn: return 9
        case .winter: return 12
        default: return 0
        }
    }
    
    var endMonth: Int {
        switch self {
        case .spring: return 5
        case .summer: return 8
        case .autumn: return 11
        case .winter: return 2
        default: return 12
        }
    }
}
