//
//  ScanDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/10/25.
//

import SwiftUI

struct ScanDetailView: View {
    
    @StateObject private var viewModel: ScanViewModel = .init()
    
    var body: some View {
        Group {
            if let product = viewModel.productData {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Çiftçi: \(product.farmer.name)")
                        Text("Konum: \(product.farmer.location.region)")
                        Text("Sertifikalar: \(product.farmer.certifications.joined(separator: ", "))")
                        
                        Divider()
                        Text("Tohum: \(product.cultivation.seed.brand) | GDO: \(product.cultivation.seed.gmo ? "Evet" : "Hayır")")
                        Text("Ekim: \(product.cultivation.plantingDate)")
                        Text("Gübre: \(product.cultivation.fertilization.first?.type ?? "-")")
                        Text("İlaçlama: \(product.cultivation.pesticides.first?.name ?? "-")")
                        
                        Divider()
                        Text("Depolama: \(product.postHarvest.storage)")
                        Text("Nakliye: \(product.postHarvest.transport.logisticsCompany)")
                        
                        Divider()
                        Text("Satış Noktası: \(product.sales.market)")
                        Text("Rafa Giriş: \(product.sales.shelfDate)")
                        Text("Son Kullanma: \(product.sales.expiryDate)")
                        
                        Divider()
                        Text("Blockchain ID: \(product.traceability.blockchainID)")
                            .font(.caption)
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text("\(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchProductData(from: "https://example.com/product.json")
                    }
            }
        }
        .navigationTitle("Ürün Bilgisi")
    }
}

#Preview {
    ScanDetailView()
}
