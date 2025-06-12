//
//  FieldAddView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/2/25.
//

import SwiftUI
import MapKit

struct FieldAddView: View {
    
    let farms : [Farm]
    
    @State private var name : String = ""
    
    @State public var field : Field? = nil
    @State public var selectingFarm : Farm? = nil
    @State public var soilType : SoilType? = nil
    @State public var irrigationType : IrrigationType? = nil
    @State public var isIrrigationInfrastructurePresent : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                Section(header: Text("General")){
                    TextField("Name", text: $name)
                        .onChange(of: name) { oldValue, newValue in
                            field?.name = newValue
                        }
                    Picker(selection: $selectingFarm) {
                        ForEach(farms){ farm in
                            Text(farm.name)
                                .tag(farm)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }label:{
                        Text("Select Farm")
                    }
                    .pickerStyle(.navigationLink)
                }
                Section{
                    NavigationLink("Choose On Map") {
                        Map{
                            
                        }
                    }
                }
                Section(header: Text("Soil & Irrigation")){
                    PickerComponent(selection: $soilType, label: "Select Soil Type", options: SoilType.allCases)
                    DisclosureGroup(isExpanded: $isIrrigationInfrastructurePresent){
                        PickerComponent(selection: $irrigationType, label: "Select Irrigation Type", options: IrrigationType.allCases)
                    }label: {
                        Toggle("Is there irrigation?" , isOn: $isIrrigationInfrastructurePresent)
                    }
                }
                
                Section(header: Text("Geographical Details")){
                    TextField("Altitude", text: .constant(""))
                    TextField("Slope(% or degree)", text: .constant(""))
                }
            }
            .navigationTitle("Add Field")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
