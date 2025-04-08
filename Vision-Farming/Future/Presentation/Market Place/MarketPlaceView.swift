//
//  MarketPlaceView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/4/25.
//

import SwiftUI

struct MarketPlaceView: View {
    
    @State private var isScanViewOpenned : Bool = false
    @State private var isProductViewOpenned : Bool = false
    
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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isScanViewOpenned.toggle()
                        } label: {
                            Image(systemName: "qrcode.viewfinder")
                        }
                        .tint(.black)
                    }
                }
                .safeAreaInset(edge: .bottom){
                    HStack{
                        Spacer()
                        Button{
                            isProductViewOpenned.toggle()
                        }label: {
                            Image(systemName: "plus")
                                .padding()
                        }
                        .tint(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                }
                .sheet(isPresented: $isProductViewOpenned){
                    UploadProductView()
                }
                .sheet(isPresented: $isScanViewOpenned) {
                    ScanView()
                }
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
