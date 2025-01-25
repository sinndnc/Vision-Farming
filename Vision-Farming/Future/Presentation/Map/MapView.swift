//
//  MapView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    
    @State var mapStyle : MapStyle = .hybrid
    @State var SettingIsActive : Bool = false
    @State var position : MapCameraPosition = .automatic
    
    @StateObject var viewModel : MapViewModel = .init()
    
    
    var body: some View {
        GeometryReader{ geoProxy in
            NavigationStack{
                ZStack{
                    MapReader { mapProxy in
                        Map(initialPosition: position){
                            if let user = viewModel.user{
                                
                                ForEach(user.fields,id: \.self.coordinates) { field in
                                    MapPolygon(coordinates: field.coordinates.toCLLocationCoordinate2D)
                                        .stroke(.blue)
                                        .foregroundStyle(.blue.opacity(0.4))
                                    Marker(coordinate: field.coordinates.getCenterOfField()) {
                                        Text("test")
                                    }
                                }
                            }
                        }
                        .mapStyle(mapStyle)
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            SettingIsActive.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .padding(7)
                                .font(.subheadline)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            TextField("Search Location", text: .constant(""))
                                .padding(10)
                                .font(.subheadline)
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                }
                .sheet(isPresented: $SettingIsActive) {
                    NavigationStack{
                        List{
                            Toggle("Theme", isOn: .constant(.random()))
                        }
                        .listStyle(.insetGrouped)
                        .navigationTitle("Filters")
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
                .task {
                    await viewModel.fetch()
                }
            }
        }
    }
}

#Preview {
    MapView()
}
