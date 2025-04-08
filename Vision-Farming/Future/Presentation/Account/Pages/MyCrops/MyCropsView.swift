//
//  MyCropsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import SwiftUI

struct MyCropsView: View {
    
    @StateObject private var viewModel = MyCropsViewModel()
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("My Crops")
    }
}

#Preview {
    MyCropsView()
}
