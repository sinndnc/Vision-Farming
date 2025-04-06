//
//  MarketPlaceView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/4/25.
//

import SwiftUI

struct MarketPlaceView: View {
    
    @StateObject private var viewModel = MarketPlaceViewModel()
    
    var body: some View {
        GeometryReader { geoProxy in
            NavigationStack{
                ScrollView{
                    LazyVStack(pinnedViews: .sectionHeaders){
                        CategoryComponent(viewModel: viewModel)
                        SuggestionComponent(viewModel: viewModel)
                            .frame(height:geoProxy.size.height * 0.2)
                        MarketComponent(viewModel: viewModel)
                    }
                }
                .navigationTitle("Market")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: .constant(""), prompt: "Search Market")
            }
        }
    }
    
    
    
    @ViewBuilder
    func marketPlaceToolBar() -> some View {
        toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .padding(5)
                            .font(.footnote)
                            .foregroundStyle(.black)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1.5)
                            }
                    }
                    .tint(.black)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .padding(5)
                            .font(.footnote)
                            .foregroundStyle(.black)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1.5)
                            }
                    }
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    MarketPlaceView()
}
