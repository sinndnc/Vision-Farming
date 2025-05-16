//
//  AddSensorView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import SwiftUI

struct AddSensorView: View {
    
    @State var newSensor : Sensor? = nil
    @State var selectingFarm : Farm? = nil
    @State var selectingField : Field? = nil
    @State var selectingSensor : SensorEnum? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel : AccountViewModel
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    Picker(selection: $selectingFarm) {
                        ForEach(viewModel.farms){ farm in
                            Text(farm.name)
                                .tag(farm)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }label:{
                        Text("Select Farm")
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker(selection: $selectingField) {
                        let filteredFields = viewModel.fields.filter{ $0.owner_farm == selectingFarm?.id }
                        ForEach(filteredFields){ field in
                            Text(field.name)
                                .tag(field)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }label:{
                        Text("Select Field of Farm")
                    }
                    .disabled(selectingFarm == nil)
                    .pickerStyle(.navigationLink)
                    
                    Picker(selection: $selectingSensor) {
                        ForEach(SensorEnum.allCases, id:\.self ){ sensor in
                            Text(sensor.toString)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .tag(sensor)
                        }
                    }label:{
                        Text("Select type of Sensor")
                    }
                    .disabled(selectingField == nil)
                    .pickerStyle(.navigationLink)
                    
                }header:{
                    Text("Select Field and Sensor")
                }
            }
            .navigationTitle("Add Sensor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard let field = selectingField else { return }
                        guard let field_id = field.id else { return }
                        guard let sensorType = selectingSensor else { return }
                        
                        let sensor = Sensor.addSensor(type: sensorType, owner_field: field_id)
                        viewModel.addSensor(sensor)
                        dismiss()
                        
                    } label: {
                        Text("Add")
                    }
                    .disabled(selectingSensor == nil)
                }
            }
        }
    }
}

