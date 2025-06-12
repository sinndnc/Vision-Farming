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
                        Text("Click to view more details")
                    }
                }
            }
            .navigationTitle("Fields")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        
                    }
                }
            }
        }
    }
}
