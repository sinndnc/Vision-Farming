//
//  CropDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import MapKit
import SwiftUI

struct CropDetailView: View {
    
    let crop : Crop
    
    var body: some View {
        List {
            Section(){
                Map{
                    MapPolygon(coordinates: crop.coordinates.toCLLocationCoordinate2D())
                        .stroke(.red, lineWidth: 1)
                        .foregroundStyle(.red.opacity(0.2))
                }
                .disabled(true)
                .mapStyle(.imagery)
                .frame(width: 350,height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .listRowBackground(Color.clear)
            Section(header: Text("General Information")){
                HStack{
                    Text("Name")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                HStack(){
                    Text("Variety")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("Leafy Green")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                HStack{
                    Text("Planted Date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.planted_date,style:.date)
                        .font(.subheadline)
                }
                HStack{
                    Text("Expected Harvest Date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                }
                VStack(alignment:.leading,spacing: 15){
                    Text("Notes")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(crop.notes)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            
            Section(header:Text("Advanced Details")){
                HStack{
                    Text("Growth Stage")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.planted_date,style:.date)
                        .font(.subheadline)
                }
                HStack{
                    Text("Irrigation Status")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                }
                HStack{
                    Text("Fertilization Recors")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                }
                HStack{
                    Text("Pesticide Application Records")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                }
                NavigationLink {
                    
                } label: {
                    HStack{
                        Text("Yield estimate")
                            .font(.subheadline)
                        Spacer()
                        Text("Ask to Farm-Bot")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Section(header: Text("Sensors and Alerts")){
                NavigationLink {
                    
                } label: {
                    Text("Sensors")
                        .font(.subheadline)
                }
                HStack{
                    Text("Disease diagnosis")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                }
            }
            Section{
//                ForEach(crop.actions,id:\.self){ action in
//                    HStack {
//                        Text("Type:")
//                            .font(.subheadline)
//                        Text(action.type)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                    HStack {
//                        Text("Note:")
//                            .font(.subheadline)
//                        Text(action.note)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                    HStack {
//                        Text("Date:")
//                            .font(.subheadline)
//                        Text(action.date,style: .date)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                }
            }header: {
                Text("Last Actions")
            }
            
        }
        .navigationTitle(crop.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    let coordinates =  [
        CLLocationCoordinate2D(latitude: 38.910493,longitude: 33.499891),
        CLLocationCoordinate2D(latitude: 38.911983,longitude: 33.501429),
        CLLocationCoordinate2D(latitude: 38.911473,longitude: 33.502689),
        CLLocationCoordinate2D(latitude: 38.909728,longitude: 33.501227)
    ]
    NavigationStack{
        CropDetailView(
            crop: Crop(
                name: "Tomato",
                notes: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
                owner_id: "",
                planted_date: .now,
                coordinates: coordinates.toGeoPoint(),
                expected_harvest_date: .now,
            )
        )
    }
}
