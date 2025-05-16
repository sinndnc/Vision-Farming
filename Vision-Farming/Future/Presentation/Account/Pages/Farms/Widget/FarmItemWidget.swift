//
//  FarmItemWidget.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/16/25.
//

import MapKit
import SwiftUI
import FirebaseFirestore

struct FarmItemWidget: View {
    
    let farm : Farm
    let geoProxy : GeometryProxy
    @State var cameraPosition : MapCameraPosition = .automatic
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Name")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(farm.name)
                    .font(.subheadline)
            }
            Divider()
            Map(
                position: $cameraPosition,
                bounds: MapCameraBounds(minimumDistance: 100),
            ) {
                Marker("", coordinate: farm.location.toCLocationCoordinate2D)
            }
            .disabled(true)
            .mapStyle(.imagery)
            .frame(height: geoProxy.size.height * 0.3)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    NavigationStack{
        GeometryReader { geo in
            FarmItemWidget(
                farm: Farm(
                    name: "Dinç Holding Farm",
                    owner_id: "",
                    location: GeoPoint.init(
                        latitude: 38.9072,
                        longitude: 27.9563
                    )
                ),
                geoProxy: geo
            )
        }
    }
}
