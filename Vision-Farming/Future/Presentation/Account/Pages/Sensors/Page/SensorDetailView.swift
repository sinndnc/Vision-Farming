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
        Text("Hello, World!")
    }
}

#Preview {
    SensorDetailView(
        sensor: Sensor(
            id: UUID().uuidString,
            unit: "",
            name: "",
            status: "",
            type: .airMoisture,
            owner_field: ""
        )
    )
}
