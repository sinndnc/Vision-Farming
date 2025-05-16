//
//  MarketWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI
import Foundation
    
struct ProductWidget : View {
    
    let product : MarketProduct
    
    var body: some View {
        VStack(alignment: .leading){
            if let image = product.image,
               let uiImage = UIImage(data: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }else{
                ProgressView()
            }
            VStack(alignment: .leading,spacing: 5){
                Text(product.name)
                    .font(.footnote)
                    .fontWeight(.medium)
                Text(product.category.rawValue.uppercased())
                    .font(.footnote)
                    .foregroundStyle(.gray)
                HStack{
                    Button{
                        
                    }label:{
                        Image(systemName: "star")
                            .font(.footnote)
                    }
                    .tint(.black)
                    Spacer()
                    Text("\(product.currency)\(product.price)")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
            .padding(10)
        }
        .background(.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
