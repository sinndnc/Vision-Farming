//
//  RootView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import BottomSheet

struct RootView: View {
    
    @State private var isPresented = false
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $rootViewModel.selectedTab){
                Tab("Dashboard", systemImage: "chart.xyaxis.line", value: .dashboard) {
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
                Tab("Catalog",systemImage: "books.vertical",value: .catalog){
                    CatalogView()
                        .tag(TabEnum.catalog)
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                }
                Tab("Calendar", systemImage: "calendar", value: .calendar) {
                    CalendarView()
                        .tag(TabEnum.calendar)
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

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    RootView()
}
