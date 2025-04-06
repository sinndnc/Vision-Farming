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
            switch viewModel.selectedTab {
            case .all:
                MarketAllPage()
            case .vegetables:
                VegetablesPage()
            case .fruits:
                Fruitspage()
            case .plants:
                PlantsPage()
            case .favorite:
                FavoritesPage()
            }
        } header: {
            MarketTabWidget(viewModel: viewModel)
        }
    }
}

#Preview {
    MarketComponent(viewModel: .init())
}
