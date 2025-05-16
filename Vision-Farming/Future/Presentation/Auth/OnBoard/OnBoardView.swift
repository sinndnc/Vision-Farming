//
//  OnBoardView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/19/25.
//

import SwiftUI

struct OnBoardView: View {
    
    @EnvironmentObject var rootViewModel : RootViewModel
    
    var body: some View {
        RootView(rootViewModel: rootViewModel)
    }
}

#Preview {
    OnBoardView()
}
