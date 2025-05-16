//
//  AllView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct MarketAllPage: View {
    
    @State var products: [MarketProduct]
    
    var body: some View {
        Section{
            Grid(alignment: .topLeading) {
                ForEach(products.chunked(into: 2), id: \.self) { rowProducts in
                    GridRow {
                        ForEach(rowProducts) { product in
                            NavigationLink {
                                ProductDetailView(product: product)
                            } label: {
                                ProductWidget(product: product)
                            }
                            .tint(.black)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
