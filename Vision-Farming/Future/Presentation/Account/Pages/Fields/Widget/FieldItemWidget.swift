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
                    .foregroundStyle(.secondary)
                Spacer()
                Text(field.name)
                    .font(.subheadline)
            }
            
            HStack{
                Text("Planted at:")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(field.planted_date,style: .date)
                    .font(.subheadline)
            }
            
            HStack{
                Text("Estimated Harvesting:")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(field.harvest_date,style: .date)
                    .font(.subheadline)
            }
            
            Divider()
            
            Map(
                position: $cameraPosition,
                bounds: MapCameraBounds(maximumDistance: 1000)
            ) {
                MapPolygon(coordinates: coordinates)
                    .stroke(.red, lineWidth: 1)
                    .foregroundStyle(.red.opacity(0.2))
                
            }
            .disabled(true)
            .mapStyle(.imagery)
            .frame(height: geoProxy.size.height * 0.175)
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
