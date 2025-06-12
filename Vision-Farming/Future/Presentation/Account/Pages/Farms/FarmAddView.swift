//
//  FarmAddView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/2/25.
//

import SwiftUI
import MapKit



struct FarmAddView: View {
    
    @State var farm : Farm? = nil
    @State var soilType : SoilType? = nil
    @State var irrigationType : IrrigationType? = nil
    
    @State private var name : String = ""
    @State private var notes : String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                Section(header: Text("General")){
                    TextField( "Farm Name", text: $name)
                        .onChange(of: name) { oldValue, newValue in
                            farm?.name = newValue
                        }
                    PickerComponent(selection: $soilType, label: "Select soil type", options: SoilType.allCases)
                    PickerComponent(selection: $irrigationType, label: "Irrigation type", options: IrrigationType.allCases)
                }
                Section(header: Text("Maps")){
                    TextField("Add Address", text: .constant(""))
                    NavigationLink("Select on Map") {
                        Map{
                            
                        }
                    }
                }
                Section(header: Text("Notes")){
                    TextField("Add Notes",text: $notes)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(minHeight: 100,alignment: .topLeading)
                        .onChange(of: notes) { oldValue, newValue in
                        }
                }
            }
        }
        .navigationTitle("Add Farm")
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

#Preview {
    FarmAddView()
}
