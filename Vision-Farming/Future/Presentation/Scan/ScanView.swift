//
//  ScanView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/12/25.
//

import SwiftUI
import AVFoundation
import BottomSheet
import VisionKit

struct ScanView :  View {
    
    @EnvironmentObject var rootViewModel : RootViewModel
    @StateObject private var viewModel = ScanViewModel()
    @State private var bottomSheetPosition : BottomSheetPosition = .relative(0.4)
    
    init() {
    }
    
    var body : some View {
        NavigationStack{
            
            QRScannerView(
                recognizedItems: $viewModel.recognizedItems
            )
            .bottomSheet(
                bottomSheetPosition: $bottomSheetPosition,
                switchablePositions: [.relative(0.175),.relative(0.4)]
            ){
                bottomContainerView
            }
            .ignoresSafeArea()
            .navigationTitle("Scan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.clear)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    @ViewBuilder
    private var bottomContainerView : some View {
        VStack {
            if let item = viewModel.recognizedItems.last {
                switch item {
                case .barcode(let barcode):
                    barcodeView(barcode: barcode)
                case .text(let text):
                    Text(text.transcript)
                @unknown default:
                    Text("Unknown")
                }
            }else{
                VStack(alignment: .leading){
                    HStack {
                        Text("Scanned barcode:")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "airtag.radiowaves.forward.fill")
                            .frame(width: 50,height: 50)
                            .background(.green.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Tomato")
                            .onTapGesture {
                                let data = "kICWYtCUK7JTTpZIFpiW/mTrSeaOAHNG62VXnJoCX/NHQe3YM6LNLKkvOT8kRK"
                                rootViewModel.navigateToTab(.catalog, with: data)
                            }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                    
                   
//                Text("scanned QR code will be appear here")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.gray)
//                    .onTapGesture {
//                        rootViewModel.navigateToTab(.catalog,with: Category(name: "Sebzeler", products: [
//                            Product(name: "Domates", description: "Taze kırmızı domates"),
//                            Product(name: "Salatalık", description: "Doğal bahçe salatalığı")
//                        ]))
//                    }
            }
        }
    }
    
    @ViewBuilder
    private func barcodeView(barcode : RecognizedItem.Barcode) -> some View {
        VStack(alignment: .leading){
            Text(barcode.payloadStringValue ?? "Unknown barcode")
                .font(.title)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
