//
//  RootView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import BottomSheet

struct RootView: View {
    
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some View {
        TabView(selection: $rootViewModel.selectedTab){
            Tab("Dashboard", systemImage: "chart.pie.fill", value: .dashboard) {
                DashboardView()
                    .tag(TabEnum.dashboard)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Community", systemImage:"person.3.fill",value: .community){
                CommunityView()
                    .tag(TabEnum.community)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Market Place",systemImage: "cart.badge.plus",value: .marketPlace){
                MarketPlaceView()
                    .tag(TabEnum.marketPlace)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Catalog",systemImage: "plus.app",value: .catalog){
                CatalogView()
                    .tag(TabEnum.catalog)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Account", systemImage: "person.circle", value: .account) {
                AccountView()
                    .tag(TabEnum.account)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .environmentObject(rootViewModel)
    }
}

#Preview {
    RootView()
}
