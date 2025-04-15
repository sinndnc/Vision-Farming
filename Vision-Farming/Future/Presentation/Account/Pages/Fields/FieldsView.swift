//
//  MyFieldsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import SwiftUI
import MapKit

struct FieldsView: View {
    
    @StateObject var viewModel : AccountViewModel
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                ForEach(viewModel.farms){ farm in
                    Section{
                        let filteredFields = viewModel.fields.filter { $0.owner_farm == farm.id }
                        ForEach(filteredFields){ field in
                            NavigationLink{
                                FieldDetailView()
                            }label:{
                                FieldItemWidget(
                                    field: field,
                                    geoProxy: geoProxy,
                                    cameraPosition: $cameraPosition
                                )
                            }
                        }
                    }header:{
                        Text(farm.name)
                    }
                }
            }
            .navigationTitle("Fields")
        }
    }
}

#Preview {
    FieldsView(viewModel: AccountViewModel())
}
