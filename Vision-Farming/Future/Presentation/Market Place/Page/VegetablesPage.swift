//
//  VegetablesPage.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct VegetablesPage: View {
    var body: some View {
        Section{
            Grid{
                GridRow {
                    MarketWidget()
                    MarketWidget()
                }
                GridRow {
                    MarketWidget()
                    MarketWidget()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    VegetablesPage()
}
