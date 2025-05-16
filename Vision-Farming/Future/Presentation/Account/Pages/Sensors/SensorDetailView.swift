//
//  SensorDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import SwiftUI

struct SensorDetailView: View {
    
    let sensor: Sensor
    
    var body: some View {
        List{
            Section(header: Text("General")){
                HStack{
                    Text("Name")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(sensor.type.toString)
                        .font(.subheadline)
                }
                HStack{
                    Text("Last Reading")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(sensor.last_reading)")
                        .font(.subheadline)
                }
                HStack{
                    Text("Last Updated")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(sensor.last_updated ?? .now,style: .date)
                        .font(.subheadline)
                }
                HStack{
                    Text("Location")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(sensor.type.toString)
                        .font(.subheadline)
                }
            }
            Section(header: Text("Details")){
                HStack{
                    Text("Battery Level")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("%46")
                        .font(.subheadline)
                }
                HStack{
                    Text("Threshold Values")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("%20 - %60")
                        .font(.subheadline)
                }
            }
            Section(header: Text("History")){
                NavigationLink{
                    
                }label:{
                    Text("Value History")
                        .font(.subheadline)
                }
                HStack{
                    Text("Predictive Analysis")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("everything is looking good 👍🏻")
                        .font(.subheadline)
                }
                NavigationLink{
                    
                }label:{
                    Text("Notifications")
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle(sensor.name)
    }
}

#Preview {
    SensorDetailView(
        sensor: Sensor(
            id: UUID().uuidString,
            unit: "%",
            name: "Soil Moisture",
            status: "active",
            type: .soilMoisture,
            owner_field: ""
        )
    )
}
