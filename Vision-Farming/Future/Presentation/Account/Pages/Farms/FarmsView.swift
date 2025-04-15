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
        List{
            ForEach(viewModel.farms,id:\.self) { farm in
                Text("\(farm.name)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .navigationTitle("Farms")
    }
}

#Preview {
    FarmsView(viewModel: AccountViewModel())
}
