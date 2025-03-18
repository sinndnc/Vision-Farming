//
//  MapView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import SwiftUI
import MapKit
import BottomSheet


struct MapView: View {
    
    @State private var mapStyle : MapStyle = .hybrid
    @State private var selectedResult : Int?
    @State private var settingSheet : Bool = false
    @State private var position : MapCameraPosition = .automatic
    
    @StateObject var viewModel : MapViewModel = MapViewModel()
    @State private var bottomSheetPosition : BottomSheetPosition = .relative(0.175)

    var body: some View {
        Map()
            .bottomSheet(
                bottomSheetPosition: $bottomSheetPosition,
                switchablePositions: [.relative(0.175),.relative(0.4)]) {
                    
                }
        
    }
}


#Preview {
    MapView()
}
