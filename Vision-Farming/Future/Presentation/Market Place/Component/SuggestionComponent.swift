//
//  SuggestionComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/6/25.
//

import SwiftUI

struct SuggestionComponent: View {
    
    @StateObject var viewModel : MarketPlaceViewModel
    
    @State private var selection : Int = 0
    
    var body: some View {
        TabView(selection: $selection){
            ForEach(1...3,id:\.self){count in
                VStack{
                    
                }
                .tag(count)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    SuggestionComponent(viewModel: MarketPlaceViewModel())
}
