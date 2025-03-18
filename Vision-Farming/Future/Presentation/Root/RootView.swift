//
//  RootView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import BottomSheet

fileprivate enum TabEnum : Hashable {
    case qr
    case map
    case dashboard
    case account
    case catalog
}

struct RootView: View {
    
    @State private var selectedTab : TabEnum = .dashboard

    var body: some View {
        TabView(selection: $selectedTab){
            Tab("Dashboard", systemImage: "chart.pie.fill", value: .dashboard) {
                DashboardView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Map", systemImage:"map.fill",value: .map){
                MapView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Scan",systemImage: "qrcode.viewfinder",value: .qr){
                ScanView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Catalog",systemImage: "plus.app",value: .catalog){
                CatalogView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            Tab("Account", systemImage: "person.circle", value: .account) {
                AccountView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
    }
}

#Preview {
    RootView()
}
