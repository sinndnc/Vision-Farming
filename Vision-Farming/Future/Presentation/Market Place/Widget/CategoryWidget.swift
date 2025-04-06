//
//  CategoryWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI
import Foundation

struct CategoryWidget : View {
    
    @StateObject var viewModel : MarketPlaceViewModel
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "house")
                .frame(width: 50,height: 50)
                .background(.green.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            Text("Spinach")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal,5)
        
    }
}
