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
                ZStack(alignment: .bottom){
                    HStack{
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
                                    .frame(height: 3)
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
                
                TabView(selection: $viewModel.selectedTab) {
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(1...5,id:\.self) { id in
                                PostView()
                                    .id(id)
                                    .padding(.vertical, 7)
                            }
                        }
                    }
                    .padding(.horizontal,10)
                    .tag(CommunityTab.trending)
                    
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(1...3,id:\.self) { id in
                                PostView()
                                    .id(id)
                                    .padding(5)
                            }
                        }
                    }
                    .padding(.horizontal,10)
                    .tag(CommunityTab.forYou)
                    
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(1...7,id:\.self) { id in
                                PostView()
                                    .id(id)
                                    .padding(5)
                            }
                        }
                    }
                    .padding(.horizontal,10)
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
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding()
        }
        .sheet(isPresented: $isExpanded) {
            AIChatView()
        }
    }
}


#Preview {
    NavigationStack{
        CommunityView()
    }
}

