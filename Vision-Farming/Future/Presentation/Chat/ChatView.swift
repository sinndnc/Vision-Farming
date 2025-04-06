//
//  AIChatView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/30/25.
//

import Foundation
import SwiftUI
import Combine

struct ChatMessage : Identifiable {
    var id : UUID = UUID()
    var text : String
    var isUser : Bool = false
}

struct ChatView : View , KeyboardReadable {
    
    @FocusState var isFocused: Bool
    
    @State private var scrollToBottom : Bool = false
    @State private var isKeyboardShowing : Bool = false
    @State private var scrollPosition = ScrollPosition(idType: UUID.self)
    
    @StateObject private var viewModel : ChatViewModel = ChatViewModel()
    
    var body: some View {
        GeometryReader{ geoProxy in
            NavigationStack{
                ScrollViewReader{ scrollProxy in
                    ScrollView{
                        LazyVStack{
                            ForEach(viewModel.messages){ message in
                                let textColor = message.isUser ? Color.black : Color.white
                                let bubbleAlignment : Alignment = message.isUser ? .trailing : .leading
                                let backgroundColor = message.isUser ? Color.gray.opacity(0.1) : Color.blue
                                
                                ZStack{
                                    Text(message.text)
                                        .padding(10)
                                        .id(message.id)
                                        .font(.subheadline)
                                        .foregroundStyle(textColor)
                                        .background(backgroundColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(
                                            maxWidth: geoProxy.size.width * 0.7,
                                            alignment: bubbleAlignment
                                        )
                                }
                                .id(message.id)
                                .frame(maxWidth: .infinity, alignment: bubbleAlignment )
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .onTapGesture{ isFocused.toggle()}
                    .scrollPosition($scrollPosition, anchor: .top)
                    .onAppear { scrollPosition.scrollTo(edge: .bottom) }
                    .onScrollTargetVisibilityChange(idType: ChatMessage.ID.self, { messages in
                        guard let lastMessageId = messages.last else { return }
                        guard let lastMessage = viewModel.messages.last else { return }
                        
                        if (lastMessage.id != lastMessageId) {
                            scrollToBottom = true
                        }else{
                            scrollToBottom = false
                        }
                    })
                    .onChange(of: viewModel.messages.count) { _, _ in
                        withAnimation { scrollToBottom(scrollProxy) }
                    }
                    .onChange(of: isKeyboardShowing) { oldValue, newValue in 
                        if (newValue) {
                            withAnimation { scrollToBottom(scrollProxy) }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    if scrollToBottom{
                        Button{
                            withAnimation{
                                scrollPosition.scrollTo(edge: .bottom)
                            }
                        }label: {
                            Image(systemName: "arrow.down")
                                .padding()
                                .foregroundStyle(.white)
                        }
                        .background(.regularMaterial)
                        .clipShape(Circle())
                    }
                }
                .safeAreaInset(edge: .bottom) { bottomBar }
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
            }
        }
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        guard let lastMessage = viewModel.messages.last else { return }
        proxy.scrollTo(lastMessage.id, anchor: .bottom)
    }
    
    @ViewBuilder
    var bottomBar : some View {
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
                .onReceive(keyboardPublisher) { isKeyboardShown in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        isKeyboardShowing = isKeyboardShown
                    }
                }
            }
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray.opacity(0.2), lineWidth: 1)
            }
            
            Button {
                viewModel.addMessage()
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




#Preview {
    NavigationStack{
        ChatView()
    }
}
