//
//  TransactionCategory.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/11/25.
//

import Foundation

enum TransactionCategory : String, Codable , CaseIterable , Identifiable {
    case seed
    case fertilizer
    case pesticide
    case labor
    case machinery
    case fuel
    case maintenance
    case water
    case rent
    case cropSales
    case livestockSales
    case governmentSubsidy
    case rentalIncome
    
    var id: String { rawValue }
    
    
    var type: TransactionType {
        switch self {
        case .seed, .fertilizer, .pesticide, .machinery, .fuel , .labor, .maintenance, .water, .rent:
            return .income
        case .cropSales, .livestockSales, .governmentSubsidy, .rentalIncome:
            return .expense
        }
    }
}
