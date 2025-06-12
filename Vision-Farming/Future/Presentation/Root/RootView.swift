//
//  RootView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import Supabase
import BottomSheet

struct RootView: View {
    
    @State private var isPresented : Bool = false
    
    @StateObject public var rootViewModel : RootViewModel
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $rootViewModel.selectedTab){
                Tab("Dashboard", systemImage: "house", value: .dashboard) {
                    let viewModel = DashboardViewModel(rootViewModel: rootViewModel)
                    DashboardView(viewModel: viewModel)
                        .tag(TabEnum.dashboard)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                Tab("Community", systemImage:"person.3.fill",value: .community){
                    let viewModel = CommunityViewModel(rootViewModel: rootViewModel)
                    CommunityView(viewModel: viewModel)
                        .tag(TabEnum.community)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                Tab("Quick Add",systemImage: "plus",value: .adding){
                    let viewModel = QuickAddViewModel(rootViewModel: rootViewModel)
                    QuickAddView(viewModel: viewModel)
                        .tag(TabEnum.adding)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                Tab("Market Place",systemImage: "cart.badge.plus",value: .marketPlace){
                    let viewModel = MarketPlaceViewModel(rootViewModel: rootViewModel)
                    MarketPlaceView(viewModel: viewModel)
                        .tag(TabEnum.marketPlace)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
               
                Tab("Budget", systemImage: "wallet.bifold", value: .budget) {
                    let viewModel = BudgetViewModel(rootViewModel: rootViewModel)
                    BudgetView(viewModel: viewModel)
                        .tag(TabEnum.budget)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
            }
            .environmentObject(rootViewModel)
           
            ChatBotWidget(
                geometry: geometry,
                isPresented: $isPresented
            )
        }
        .sheet(isPresented:$isPresented){
            ChatView()
        }
    }
}



#Preview {
    let loader = MockService().mockLoader()
    RootView(rootViewModel: RootViewModel(loader: loader))
}
