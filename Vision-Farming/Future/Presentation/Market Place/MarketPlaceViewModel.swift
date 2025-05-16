//
//  MarketPlaceViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/4/25.
//

import Foundation
import Combine

enum MarketPlaceTab : String , CaseIterable {
    case all = "All"
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case plants = "Plants"
    case favorite = "Favorite"
}

final class MarketPlaceViewModel : BaseViewModel {
    
    @Published var categories : [Category] = []
    @Published var currentTab : MarketPlaceTab = .all
    
    @Published public var products : [MarketProduct] = []
    
    init(rootViewModel : RootViewModel) {
        super.init()
        rootViewModel.$products
            .assign(to: &$products)
    }
    
}
