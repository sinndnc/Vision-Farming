//
//  SensorGroupDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import SwiftUI

struct SensorGroupDetailView: View {
    
    let sensors: [Sensor]
    
    var body: some View {
        List{
            ForEach(sensors,id:\.self) { sensor in
                Text(sensor.name)
            }
        }
        .navigationTitle("Sensors Details")
    }
}

#Preview {
    SensorGroupDetailView(sensors: [])
}
