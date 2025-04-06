//
//  MarketPlaceViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/4/25.
//

import Foundation

enum MarketPlaceTab : String , CaseIterable {
    case all = "All"
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case plants = "Plants"
    case favorite = "Favorite"
}

final class MarketPlaceViewModel : ObservableObject {
    
    @Published var selectedTab : MarketPlaceTab = .all

}
