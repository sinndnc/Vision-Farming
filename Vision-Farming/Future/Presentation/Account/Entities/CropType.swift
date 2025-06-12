//
//  CropDetail.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/7/25.
//

enum CropType : String, CaseIterable, SelectableItem{
    case organic
    case inorganic
    case hybrid
    
    var id: String { rawValue }
    
    var displayText: String {
        rawValue
    }
}
