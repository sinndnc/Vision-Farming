//
//  FavoritesPage.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct FavoritesPage: View {
    var body: some View {
        Grid(){
            GridRow {
                MarketWidget()
                MarketWidget()
            }
            GridRow {
                MarketWidget()
                MarketWidget()
            }
            GridRow {
                MarketWidget()
                MarketWidget()
            }
            GridRow {
                MarketWidget()
                MarketWidget()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    FavoritesPage()
}
