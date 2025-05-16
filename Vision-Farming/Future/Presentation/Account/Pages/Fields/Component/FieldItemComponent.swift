//
//  FieldItemComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/20/25.
//

import SwiftUI
import MapKit


struct FieldItemComponent: View {
    
    let farm : Farm
    let geoProxy : GeometryProxy
    @StateObject var viewModel : AccountViewModel
    
    @State private var isExpanded : [Farm:Bool] = [:]
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        DisclosureGroup(isExpanded: Binding(
            get: { isExpanded[farm, default: true] },
            set: { isExpanded[farm] = $0 }
        )) {
            let filteredFields = viewModel.fields.filter { $0.owner_farm == farm.id }
            ForEach(filteredFields){ field in
                NavigationLink{
                    FieldDetailView(field:field,geo: geoProxy)
                }label:{
                    FieldItemWidget(
                        field: field,
                        geoProxy: geoProxy,
                        cameraPosition: $cameraPosition
                    )
                }
            }
        } label: {
            Text(farm.name)
                .font(.subheadline)
        }
    }
}
