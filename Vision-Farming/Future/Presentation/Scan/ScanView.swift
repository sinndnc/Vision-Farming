//
//  ScanView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/12/25.
//

import SwiftUI
import AVFoundation
import BottomSheet

struct ScanView :  View {
    
    @StateObject private var viewModel = ScanViewModel()
    @State private var bottomSheetPosition : BottomSheetPosition = .relative(0.175)
    
    var body : some View {
        DocumentScannerView(recognizedItems: $viewModel.recognizedItems)
            .bottomSheet(
                bottomSheetPosition: $bottomSheetPosition,
                switchablePositions: [.relative(0.175),.relative(0.4)]) {
                    bottomContainerView
                }
    }
    
    private var bottomContainerView : some View {
        VStack {
            if let item = viewModel.recognizedItems.last {
                switch item {
                case .barcode(let barcode):
                    //Daha güzel bir view yapılacak
                    Text(barcode.payloadStringValue ?? "Unknown barcode")
                case .text(let text):
                    Text(text.transcript)
                    
                @unknown default:
                    Text("Unknown")
                }
            }else{
                Text("scanned QR code will be appear here")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
        }
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
