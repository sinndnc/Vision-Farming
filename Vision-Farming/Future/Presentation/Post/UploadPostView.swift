//
//  PostView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/8/25.
//

import SwiftUI

struct UploadPostView: View {
     
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PostViewModel = .init()
    
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Ürün Adı", text: $name)
                TextField("Açıklama", text: $description)
                TextField("Fiyat", text: $price)
                    .keyboardType(.decimalPad)
                
                Button("Ürünü Ekle") {
                    dismiss()
                }
            }
            .navigationTitle("Create Post")
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
    UploadPostView()
}
