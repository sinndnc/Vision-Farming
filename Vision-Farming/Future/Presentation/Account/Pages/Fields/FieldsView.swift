//
//  MyFieldsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import SwiftUI

struct FieldsView: View {
    
    @StateObject var viewModel : AccountViewModel
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                ForEach(viewModel.farms){ farm in
                    Section{
                        FieldItemComponent(
                            farm: farm,
                            geoProxy: geoProxy,
                            viewModel: viewModel
                        )
                    } footer:{
                        HStack{
                            Spacer()
                            Text("Size (m²)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("14.758")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Fields")
        }
    }
}
