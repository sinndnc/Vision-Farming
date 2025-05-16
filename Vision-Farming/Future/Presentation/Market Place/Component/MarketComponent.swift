//
//  MarketComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct MarketComponent: View {
    
    @StateObject var viewModel : MarketPlaceViewModel
    
    var body: some View {
        Section {
            switch viewModel.currentTab {
            case .all:
                MarketAllPage(products: viewModel.products)
            case .vegetables:
                VegetablesPage(products: viewModel.products)
            case .fruits:
                Fruitspage(products: viewModel.products)
            case .plants:
                PlantsPage(products: viewModel.products)
            case .favorite:
                FavoritesPage(products: viewModel.products)
            }
        } header: {
            MarketTabWidget(viewModel: viewModel)
        }
    }
}

