//
//  UploadProductView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import SwiftUI

struct UploadProductView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Ürün Adı", text: .constant(""))
                TextField("Açıklama", text: .constant(""))
                TextField("Fiyat", text: .constant(""))
                    .keyboardType(.decimalPad)
                
                Button("Ürünü Ekle") {
                    dismiss()
                }
            }
            .navigationTitle("Upload Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

#Preview {
    UploadProductView()
}
