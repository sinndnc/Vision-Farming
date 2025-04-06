//
//  CommunityTabWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/6/25.
//

import SwiftUI

struct CommunityTabWidget: View {
    
    @StateObject var viewModel : CommunityViewModel
    
    var body: some View {
        ZStack(alignment: .bottom){
            HStack(spacing:0){
                ForEach(CommunityTab.allCases,id: \.self){ tab in
                    let selectedColor = viewModel.selectedTab == tab ? Color.black : Color.gray
                    let selectedIndicator = viewModel.selectedTab == tab ? Color.blue : Color.clear
                    
                    VStack{
                        Button {
                            withAnimation(.easeIn) {
                                viewModel.selectedTab = tab
                            }
                        } label: {
                            Text(tab.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                        }
                        .tint(selectedColor)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(selectedIndicator)
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Divider()
        }
        .padding(.top,10)
        .background(.white)
    }
}

#Preview {
    CommunityTabWidget(viewModel: CommunityViewModel())
}
