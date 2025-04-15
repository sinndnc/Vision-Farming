//
//  SensorsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/21/25.
//

import SwiftUI

struct SensorsView: View {
    
    @State var isPresented : Bool = false
    
    @State var isExpanded : Bool = true
    @StateObject var viewModel : AccountViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.farms){ farm in
                Section{
                    let filteredFields = viewModel.fields.filter { $0.owner_farm == farm.id }
                    ForEach(filteredFields) { field in
                        DisclosureGroup(isExpanded: $isExpanded) {
                            let filteredSensors = viewModel.sensors.filter{$0.owner_field == field.id}
                            let groupedSensor = Dictionary(grouping: filteredSensors, by: { $0.type })
                            ForEach(groupedSensor.keys.sorted{ $0 == $1},id:\.self) { sensor in
                                let groupSensors = groupedSensor[sensor] ?? []
                                NavigationLink{
                                    SensorGroupDetailView(sensors:groupSensors)
                                }label:{
                                    HStack{
                                        Text(sensor.toString)
                                            .font(.callout)
                                            .fontWeight(.medium)
                                        Spacer()
                                        Text("\(groupSensors.count)")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let sensor = viewModel.sensors[index]
                                    viewModel.deleteSensor(sensor)
                                }
                            }
                        } label: {
                            HStack{
                                Text(field.name)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }header:{
                    Text(farm.name)
                }
            }
        }
        .background(.regularMaterial)
        .navigationTitle("Sensors")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    isPresented.toggle()
                }label:{
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddSensorView(viewModel:viewModel)
        }
    }
}


#Preview {
    NavigationStack{
        SensorsView(viewModel: AccountViewModel())
    }
}
