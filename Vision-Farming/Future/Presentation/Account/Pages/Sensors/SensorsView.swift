//
//  SensorsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/21/25.
//

import SwiftUI

struct SensorsView: View {
    
    @StateObject var viewModel: SensorsViewModel = SensorsViewModel()
    
    var body: some View {
        List{
            Section {
                ForEach(viewModel.groupedSensors.keys.sorted(), id: \.self) { key in
                    let sensors = viewModel.groupedSensors[key] ?? []
                    NavigationLink {
                        SensorRowView(sensors: sensors)
                            .navigationTitle(key)
                    } label: {
                        HStack{
                            if viewModel.isEditing{
                                Image(systemName: "line.3.horizontal")
                                    .foregroundStyle(.gray)
                            }
                            Text(key)
                            Spacer()
                            Text("\(viewModel.activeSensors(sensors))")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                Button { viewModel.isSheetOpen.toggle() } label: { Text("Add Sensor") }
                
            }header: {
                Text("Connected Sensors")
            }
            
            Section {
                Text("test")
            } header: {
                Text("Notifications and Warnings")
            }
        }
        .navigationTitle("Sensors")
        .toolbar {
            Button {
                withAnimation {
                    viewModel.isEditing.toggle()
                }
            } label: {
                Text(viewModel.isEditing ? "Done" : "Edit")
            }
        }
        .sheet(isPresented: $viewModel.isSheetOpen) {
            
        }
    }
    
    struct SensorRowView: View {
        
        var sensors: [Sensor]
        @StateObject var viewModel : SensorsViewModel = .init()
        
        var body: some View {
            List{
                ForEach(sensors){ sensor in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(sensor.name)
                                .font(.headline)
                            Text("\(sensor.value, specifier: "%.2f") \(sensor.unit)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Son Güncelleme: \(sensor.lastUpdated, style: .relative)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if sensor.isActive {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }
                .onDelete(perform: viewModel.removeItem)
            }
        }
    }

}


#Preview {
    NavigationStack{
        SensorsView()
    }
}
