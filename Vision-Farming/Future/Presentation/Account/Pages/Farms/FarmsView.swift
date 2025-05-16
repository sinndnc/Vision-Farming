//
//  MyFarmsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import SwiftUI

struct FarmsView: View {
    
    @StateObject var viewModel : AccountViewModel
    
    var body: some View {
        GeometryReader { geoProxy in
            List{
                ForEach(viewModel.farms,id:\.self) { farm in
                    Section{
                        NavigationLink {
                            FarmDetailView(farm: farm)
                        } label: {
                            FarmItemWidget(farm: farm, geoProxy: geoProxy)
                        }
                    } footer:{
                        HStack{
                            Spacer()
                            Text("Size (m²)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("223.3223")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .navigationTitle("Farms")
    }
}

