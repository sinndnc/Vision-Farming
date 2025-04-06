//
//  CategoryComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct CategoryComponent : View {
    
    @StateObject var viewModel : MarketPlaceViewModel
    
    var body : some View{
        Section {
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 15){
                    ForEach(0...4,id: \.self){ int in
                        CategoryWidget(viewModel:viewModel)
                    }
                }
                .padding(.horizontal)
            }
        } header: {
            HStack{
                Text("Categories")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
                .tint(.black)
            }
            .padding()
            .background(.white)
        }
    }
    
}
