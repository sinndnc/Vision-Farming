//
//  AIChatView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/30/25.
//

import Foundation
import SwiftUI

struct AIChatMessage : Identifiable {
    var id : UUID = UUID()
    var text : String
    var isUser : Bool = false
}


struct AIChatView : View {
    
    @FocusState var isFocused: Bool
    @StateObject var viewModel : AIChatViewModel = AIChatViewModel()
    
    var body: some View {
        GeometryReader { geoProxy in
            NavigationStack{
                VStack{
                    ScrollViewReader { scrollProxy in
                        ScrollView {
                            if viewModel.messages.isEmpty{
                                HStack{
                                    Image(systemName: "ellipsis")
                                        .padding()
                                        .font(.headline)
                                        .background(.blue)
                                        .foregroundStyle(.white)
                                        .symbolEffect(.variableColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    Spacer()
                                }
                            }else{
                                ForEach(viewModel.messages){ message in
                                    let textColor = message.isUser ? Color.black : Color.white
                                    let bubbleAlignment : Alignment = message.isUser ? .trailing : .leading
                                    let backgroundColor = message.isUser ? Color.gray.opacity(0.1) : Color.blue
                                    
                                    ZStack{
                                        Text(message.text)
                                            .padding(10)
                                            .font(.subheadline)
                                            .foregroundStyle(textColor)
                                            .background(backgroundColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(
                                                maxWidth: geoProxy.size.width * 0.7,
                                                alignment: bubbleAlignment
                                            )
                                        
                                        
                                    }
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: bubbleAlignment
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .onTapGesture {
                        isFocused.toggle()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Menu {
                            Text("Select chat")
                        } label: {
                            HStack(spacing: 5){
                                Text("Chat")
                                    .fontWeight(.medium)
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                            }
                        }
                        .tint(.black)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .safeAreaInset(edge: .bottom) {
                        HStack(alignment: .bottom){
                            HStack(alignment: .bottom){
                                Button {
                                    viewModel.isDocumentPickerPresented.toggle()
                                } label: {
                                    Image(systemName: "folder.badge.plus")
                                }
                                .tint(.blue)
                                .confirmationDialog(
                                    "Are you sure you want to import this file?",
                                    isPresented: $viewModel.isDocumentPickerPresented
                                ) {
                                    Button {
                                        
                                    } label: {
                                        Text("Import")
                                    }
                                    Button("Cancel", role: .cancel) {
                                        
                                    }
                                }
                                
                                TextField(
                                    "Can ask to everything here",
                                    text: $viewModel.textfield,
                                    axis: .vertical
                                )
                                .lineLimit(8)
                                .focused($isFocused)
                               
                            }
                            .padding(10)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray.opacity(0.2), lineWidth: 1)
                            }
                            
                            Button {
                                viewModel.sendMessage()
                            } label: {
                                Image(systemName: "paperplane")
                                    .font(.headline)
                            }
                            .tint(.blue)
                            .padding(.vertical,10)
                        }
                        .padding()
                        .background(.regularMaterial)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        AIChatView()
    }
}
