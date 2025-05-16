//
//  FieldDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//


import SwiftUI
import MapKit

struct FieldDetailView: View {
    
    let field : Field
    let geo : GeometryProxy
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ScrollView{
            Map{
                MapPolygon(coordinates: field.coordinates.toCLLocationCoordinate2D())
                    .stroke(.red, lineWidth: 1)
                    .foregroundStyle(.red.opacity(0.2))
            }
            .disabled(true)
            .mapStyle(.imagery)
            .frame(height: geo.size.height * 0.3)
            List{
                Section(header: Text("General Information")){
                    HStack{
                        Text("Name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(field.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    HStack(){
                        Text("Soil Type")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Sandy")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    HStack{
                        Text("Irrigation System")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Distillation Type")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Soil Moisture")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("%72")
                            .font(.subheadline)
                    }
                    HStack(){
                        Text("Ph")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("7.1")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                Section(header:Text("Mineral Analysis")){
                    HStack{
                        Text("Nitrogen (N)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("24.5")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Phosphorus (P)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("1.5")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Potassium (K)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("7.23")
                            .font(.subheadline)
                    }
                }
                Section(header: Text("Sensors and Alerts")){
                    NavigationLink {
                        
                    } label: {
                        Text("Sensors")
                            .font(.subheadline)
                        Spacer()
                        Text("23")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Alert")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("1")
                            .font(.subheadline)
                    }
                }
                Section{
                    
                }header: {
                    Text("Last Actions")
                }
            }
            .scrollDisabled(true)
            .frame(height: geo.size.height ,alignment: .top)
        }
        .navigationTitle(Text("Fields Details"))
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    GeometryReader { geo in
        FieldDetailView(
            field: Field(
                name: "Karacabey",
                owner_farm: "",
                coordinates: [],
                harvest_date: .now,
                planted_date: .now
            ),
            geo:geo
        )
    }
}
