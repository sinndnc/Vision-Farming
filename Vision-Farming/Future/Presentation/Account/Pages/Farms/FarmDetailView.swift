//
//  FarmDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/13/25.
//

import FirebaseFirestore
import SwiftUI
import MapKit

struct FarmDetailView: View {
    
    let farm : Farm
    
    var body: some View {
        List{
            Section(header: Text("Show on Maps")){
                Map{
                    Marker(coordinate: farm.location.toCLocationCoordinate2D) {}
                }
                .mapStyle(.imagery)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .frame(width: 350,height: 250)
            .listRowBackground(Color.clear)
            
            Section(header: Text("General")){
                HStack{
                    Text("Name")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.name)
                        .font(.subheadline)
                }
                NavigationLink{
                    
                }label:{
                    HStack{
                        Text("Fields")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("5")
                            .font(.subheadline)
                    }
                }
                HStack{
                    Text("Adress")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.location.description)
                        .font(.subheadline)
                }
            }
            Section(header: Text("Details")){
                HStack{
                    Text("Irrıgation Capacity")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
                HStack{
                    Text("Warehouse Capacity")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
                HStack{
                    Text("Machine Inventory")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
            }
            Section(header: Text("Advanced")) {
                HStack{
                    Text("Operational Status")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
                HStack{
                    Text("Energy Usage")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
                HStack{
                    Text("Maintenance History")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(farm.owner_id)
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle(farm.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        FarmDetailView(
            farm : Farm(
                name: "Karacaören",
                owner_id: "",
                location: GeoPoint(latitude: 12.4432, longitude: 24.3242)
            )
        )
    }
}
