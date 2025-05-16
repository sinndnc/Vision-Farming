//
//  SensorGroupDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import SwiftUI

struct SensorGroupDetailView: View {
    
    let sensors: [Sensor]
    @State private var isExpanded : [Sensor : Bool] = [:]
    
    var body: some View {
        List{
            Section{
                ForEach(Array(sensors.enumerated()),id:\.offset) { (index,sensor) in
                    DisclosureGroup(isExpanded: Binding(
                        get: { isExpanded[sensor, default: true] },
                        set: { isExpanded[sensor] = $0 }
                    )){
                        NavigationLink {
                            SensorDetailView(sensor: sensor)
                        } label: {
                            VStack{
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
                            }
                        }
                    } label: {
                        Text("\(sensor.name) \(index+1)")
                            .font(.subheadline)
                    }
                }
            }footer: {
                Text("Click to view more details")
            }
        }
        .navigationTitle("Sensors Details")
    }
}

#Preview {
    SensorGroupDetailView(sensors: [])
}
