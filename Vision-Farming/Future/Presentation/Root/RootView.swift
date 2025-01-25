//
//  RootView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import Charts


fileprivate enum Section: Hashable {
    case qr
    case map
    case dashboard
    case account
}

struct RootView: View {
    
    @State private var selection : Section = .map
    
    var body: some View {
        TabView(selection: $selection ){
            Tab("Dashboard", systemImage: "chart.pie.fill", value: .dashboard) {
                DashboardView()
            }
            Tab("Map", systemImage:"map.fill",value: .map){
                MapView()
            }
            Tab("Add",systemImage: "plus.app",value: .qr){
                Text("")
            }
            Tab("Scan",systemImage: "qrcode.viewfinder",value: .qr){
                Text("")
            }
            Tab("Account", systemImage: "person.circle", value: .account) {
                AccountView()
            }
        }
    }
}

#Preview {
    RootView()
}
