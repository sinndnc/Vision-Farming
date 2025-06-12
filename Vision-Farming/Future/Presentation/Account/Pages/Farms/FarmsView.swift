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
                        Text("Click to view more details")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        
                    }
                }
            }
        }
        .navigationTitle("Farms")
    }
}

