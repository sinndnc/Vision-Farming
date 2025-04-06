//
//  MarketWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI
import Foundation
    
struct MarketWidget : View {
    
    var body: some View {
        VStack(alignment: .leading){
            Image(systemName: "house")
                .frame(maxWidth: .infinity,minHeight: 150)
                .background(.green)
            VStack(alignment: .leading,spacing: 5){
                Text("Spinach")
                    .font(.footnote)
                    .fontWeight(.medium)
                Text("Leafly vegetables")
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
                    Text("$12.97")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
            .padding(.bottom,5)
            .padding(.horizontal,10)
        }
        .background(.blue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
