//
//  DashboardView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel: DashboardViewModel = .init()
    
    var body: some View {
        GeometryReader { GeometryProxy in
            NavigationStack(){
                ScrollView(showsIndicators: false) {
                    LazyVStack(pinnedViews: .sectionHeaders){
                        WeatherComponent()
                        SoilMoistureComponent()
                        SensorComponent()
                    }
                }
                .padding(.horizontal)
                .navigationTitle(Text("Dashboard"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink{
                            AccountView()
                        } label:{
                            Image(systemName: "person")
                                .padding(10)
                                .background(.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .tint(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
