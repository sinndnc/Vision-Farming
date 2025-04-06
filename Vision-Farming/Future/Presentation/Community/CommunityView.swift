//
//  CommunityView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import SwiftUI
import SlidingTabView


struct CommunityView: View {
    
    @StateObject var viewModel : CommunityViewModel = CommunityViewModel()
    @State  var isExpanded: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                CommunityTabWidget(viewModel: viewModel)
                
                TabView(selection: $viewModel.selectedTab) {
                    TrendingView()
                        .tag(CommunityTab.trending)
                    ForYouView()
                        .tag(CommunityTab.forYou)
                    FollowingView()
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
                    Button{
                        
                    }label:{
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.subheadline)
                    }
                    .tint(.black)
                }
            }
        }
        .safeAreaInset(edge: .bottom){
            HStack{
                Spacer()
                Button{
                    isExpanded.toggle()
                }label: {
                    Image(systemName: "brain.head.profile")
                        .padding()
                }
                .tint(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .sheet(isPresented: $isExpanded) {
            ChatView()
        }
    }
}


#Preview {
    NavigationStack{
        CommunityView()
    }
}

