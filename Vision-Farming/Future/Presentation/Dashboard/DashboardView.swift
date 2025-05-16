//
//  DashboardView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var isPresented : Bool = false
    @StateObject private var viewModel: DashboardViewModel = DashboardViewModel()
    @EnvironmentObject public var rootViewModel: RootViewModel
    
    var body: some View {
        GeometryReader { geometryProxy in
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
                        Button{
                            isPresented.toggle()
                        } label:{
                            if let user = rootViewModel.user,
                               let data = user.image,
                               let uiImage = UIImage(data: data)
                            {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 40,height: 40)
                            }else{
                                Rectangle()
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .frame(width: 40,height: 40)
                            }
                        }
                        .tint(.black)
                    }
                }
                .sheet(isPresented: $isPresented) {
                    let viewModel = AccountViewModel(rootViewModel: rootViewModel)
                    AccountView(viewModel: viewModel)
                }
            }
        }
       
    }
}

#Preview {
    DashboardView()
}
