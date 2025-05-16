//
//  Fruitspage.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct Fruitspage: View {
    
    @State var products: [MarketProduct]
    
    var body: some View {
        Section {
            Grid{
                let filteredProducts = products.filter{ $0.category == .fruits}
                ForEach(filteredProducts.chunked(into: 2), id: \.self) { rowProducts in
                    GridRow {
                        ForEach(rowProducts) { product in
                            ProductWidget(product: product)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
