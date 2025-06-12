//
//  TransactionType.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//


enum TransactionType: String, Codable , CaseIterable ,Identifiable {
    case income
    case expense
    
    var id : String { rawValue }
}
