//
//  DashboardView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var test : Bool = false
    @State private var showAccount: Bool = false
    @State private var showCalendar: Bool = false
    @StateObject public var viewModel: DashboardViewModel
    @EnvironmentObject public var rootViewModel : RootViewModel
    
    var body: some View {
        GeometryReader { geometryProxy in
            NavigationStack{
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
                            showAccount.toggle()
                        } label:{
                            if let user = viewModel.user,
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
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack{
                            Button{
                                showCalendar.toggle()
                            }label: {
                                Image(systemName: "calendar")
                            }
                            .tint(.black)
                            
                            Button{
                                test.toggle()
                            }label: {
                                Image(systemName: "line.3.horizontal")
                            }
                            .tint(.black)
                        }
                    }
                   
                }
                .sheet(isPresented: $test) {
                }
                .sheet(isPresented: $showAccount) {
                    let viewModel = AccountViewModel(rootViewModel: rootViewModel)
                    AccountView(viewModel: viewModel)
                }
                .sheet(isPresented:  $showCalendar) {
                    let viewModel = CalendarViewModel(rootViewModel: rootViewModel)
                    CalendarView(viewModel: viewModel)
                }
            }
        }
       
    }
}
