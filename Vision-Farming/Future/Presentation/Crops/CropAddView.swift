//
//  CropAddView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/1/25.
//

import SwiftUI

struct CropAddView: View {
    
    
    @State var selectedType : CropType? = nil
    @State var selecttedField : Field? = nil
    
    @State private var name : String = ""
    @State private var notes : String = ""
    
    @StateObject var viewModel : CropViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !notes.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedType != nil
    }
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                Section(header: Text("General")){
                    TextField( "Crop Name", text: $name)
                    PickerComponent(selection: $selectedType, label: "Select Crop Type", options: CropType.allCases)
                    DisclosureGroup("Select Field") {
                        if selecttedField != nil{
                            VStack(alignment: .leading){
                                FieldItemWidget(
                                    field: selecttedField!,
                                    geoProxy: geoProxy,
                                    cameraPosition: .constant(.automatic)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selecttedField = nil
                                    }
                                }
                                Divider()
                                Text("If you want to change the selected field, tap anywhere")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray)
                            }
                        }else{
                            ForEach(viewModel.fields,id: \.self) { field in
                                Button{
                                    withAnimation {
                                        selecttedField = field
                                    }
                                }label:{
                                    Text(field.name)
                                }
                            }
                        }
                    }
                    .tint(.black)
                }
                Section(header: Text("Dates")){
                    DatePicker("Planted Date", selection: .constant(.now), displayedComponents: .date)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    DatePicker("Harvested Date", selection: .constant(.now), displayedComponents: .date)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                Section(header: Text("Notes")){
                    TextField("Add Notes",text: $notes)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(minHeight: 100,alignment: .topLeading)
                }
            }
        }
        .navigationTitle("Add Crop")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    let crop = Crop(
                        name: name,
                        notes: notes,
                        owner_id: viewModel.user!.id!,
                        planted_date: .now,
                        coordinates: selecttedField?.coordinates ?? [],
                        expected_harvest_date: .now)
                    viewModel.addCrop(for: crop)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}
