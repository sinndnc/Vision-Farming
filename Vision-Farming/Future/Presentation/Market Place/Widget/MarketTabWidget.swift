//
//  MarketTabView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct MarketTabWidget: View {
    
    @StateObject var viewModel : MarketPlaceViewModel
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing:0){
                ForEach(MarketPlaceTab.allCases,id: \.self){ tab in
                    let selectedColor = viewModel.selectedTab == tab ? Color.black : Color.gray
                    let selectedIndicator = viewModel.selectedTab == tab ? Color.blue : Color.clear
                    
                    VStack(spacing:0){
                        Button {
                            withAnimation(.easeIn) {
                                viewModel.selectedTab = tab
                            }
                        } label: {
                            Text(tab.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                        }
                        .padding()
                        .tint(selectedColor)
                        
                        
                        Rectangle()
                            .frame(height: 3)
                            .foregroundStyle(selectedIndicator)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.white)
    }
}

#Preview {
    MarketTabWidget(viewModel: MarketPlaceViewModel())
}
