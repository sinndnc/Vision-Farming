//
//  FieldItemWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import SwiftUI
import MapKit

struct FieldItemWidget: View {
    
    let field : Field
    let geoProxy : GeometryProxy
    @Binding var cameraPosition : MapCameraPosition
    
    var body: some View {
        
        let coordinates = field.coordinates.toCLLocationCoordinate2D()
        
        VStack(alignment:.leading){
            HStack{
                Text("Name:")
                    .font(.subheadline)
                Text(field.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            HStack{
                Text("Planted at:")
                    .font(.subheadline)
                Text(field.planted_date,style: .date)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            HStack{
                Text("Estimated Harvesting:")
                    .font(.subheadline)
                Text(field.harvest_date,style: .date)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            Divider()
            
            Map(position: $cameraPosition) {
                MapPolygon(coordinates: coordinates)
                    .stroke(.red, lineWidth: 1)
                    .foregroundStyle(.red.opacity(0.2))
                
            }
            .disabled(true)
            .mapStyle(.imagery)
            .frame(height: geoProxy.size.height * 0.2)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    GeometryReader { geo in
        FieldItemWidget(
            field: Field(
                name: "",
                owner_farm: "",
                coordinates: [],
                harvest_date: .now,
                planted_date: .now
            ),
            geoProxy: geo,
            cameraPosition: .constant(.automatic)
        )
    }
}
