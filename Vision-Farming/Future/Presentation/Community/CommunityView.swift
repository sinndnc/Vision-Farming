//
//  CommunityView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import SwiftUI
import SlidingTabView


struct CommunityView: View {
    
    @State private var isPresented: Bool = false
    @StateObject public var viewModel : CommunityViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                CommunityTabWidget(viewModel: viewModel)
                TabView(selection: $viewModel.selectedTab) {
                    TrendingPage(viewModel: viewModel)
                        .tag(CommunityTab.trending)
                    ForYouPage(viewModel: viewModel)
                        .tag(CommunityTab.forYou)
                    FollowingPage(viewModel: viewModel)
                        .tag(CommunityTab.following)
                }
                .background(.gray.opacity(0.2))
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
            .navigationTitle("Community")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button{
                            
                        }label:{
                            Image(systemName: "bell")
                                .font(.footnote)
                        }
                        .tint(.black)
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom){
            HStack{
                Spacer()
                Button{
                    isPresented.toggle()
                }label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .tint(.white)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .sheet(isPresented: $isPresented) {
            AddPostView()
        }
    }
}
