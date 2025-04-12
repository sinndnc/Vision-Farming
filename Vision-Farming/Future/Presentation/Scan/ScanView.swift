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
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var rootViewModel : RootViewModel
    @StateObject private var viewModel = ScanViewModel()
    @State private var bottomSheetPosition : BottomSheetPosition = .relative(0.35)
    
    
    var body : some View {
        NavigationStack{
            
            QRScannerView(
                recognizedItems: $viewModel.recognizedItems
            )
            .bottomSheet(
                bottomSheetPosition: $bottomSheetPosition,
                switchablePositions: [.relative(0.1),.relative(0.35)]
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
        VStack() {
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
                barcodeView()
                
//                Text("scanned QR code will be appear here")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.gray)
            }
        }
    }
    
    @ViewBuilder
    private func barcodeView(barcode : RecognizedItem.Barcode? = nil) -> some View {
        VStack(alignment: .leading){
            HStack {
                Text("Scanned Details:")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            HStack(alignment: .top){
                Image(systemName: "plant")
                    .frame(width: 75,height: 75)
                    .background(.green.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment:.leading){
                    Text("Vegetables")
                        .fontWeight(.semibold)
                    Text("Tomato")
                        .fontWeight(.semibold)
                }
                Spacer()
                NavigationLink {
                    ScanDetailView()
                } label: {
                    Text("Show More")
                        .padding(.vertical,5)
                        .padding(.horizontal)
                        .background(.yellow)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1)
                        }
                }
                .frame(height: 75)
//                    dismiss()
//                    let data = "kICWYtCUK7JTTpZIFpiW/mTrSeaOAHNG62VXnJoCX/NHQe3YM6LNLKkvOT8kRK"
//                    rootViewModel.navigateToTab(.catalog, with: data)
            }
            HStack{
                Text("Manufacturer:")
                    .fontWeight(.semibold)
                Text("ULKER AŞ.")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Field:")
                    .fontWeight(.semibold)
                Text("Afyon-Sivrihisar Ulker Çiftlikleri")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            HStack {
                Text("Part no:")
                    .fontWeight(.semibold)
                Text("100-440-0.750-3434-A")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            HStack{
                Text("Barcode:")
                    .fontWeight(.semibold)
                Text("C0424PP-PN-HSC0424PP")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            HStack{
                Text("Blockchain Hash:")
                    .fontWeight(.semibold)
                Text("0xff8c9dafe4e9aef9dfeeb71ca4fc59f42bccc56cc85c024a3b13719587b7866b")
                    .lineLimit(1)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .truncationMode(.middle)
            }
        }
        .padding(.horizontal)
        .safeAreaPadding(.bottom)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    NavigationStack{
        ScanView()
    }
}
