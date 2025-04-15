//
//  PostView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/8/25.
//

import SwiftUI

struct AddPostView: View {
     
    @Environment(\.dismiss) private var dismiss
    
    @State private var content : String = ""
    
    var body: some View {
        
        NavigationStack{
            List {
                TextEditor(text: $content)
                    .frame(height: 200)
                    .overlay{
                        HStack() {
                            if content.isEmpty{
                                Text("My plants are so healthy!")
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                        }
                        .padding(.leading,5)
                        .padding(.top,8)
                        .frame(width: .infinity, height: 200,alignment: .topLeading)
                    }
                    .onChange(of: content) {
                        content = String(content.prefix(1000))
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
    AddPostView()
}
