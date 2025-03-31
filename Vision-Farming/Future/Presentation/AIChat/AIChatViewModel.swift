//
//  AIChatViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/30/25.
//

import Foundation
import CoreML

final class AIChatViewModel : ObservableObject {
     
    @Published var textfield : String = ""
    @Published var messages : [AIChatMessage] = []
    @Published var isDocumentPickerPresented : Bool = false
    
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.messages = [self.initalMessage]
        }
        
    }
    
    func sendMessage() {
        textfield.trimPrefix(while: \.isWhitespace)
        if textfield.isEmpty { return }
        let newMessage = AIChatMessage(text: textfield,isUser: true)
        self.messages.append(newMessage)
        self.textfield = ""
    }
}


extension AIChatViewModel {
    
    var initalMessage : AIChatMessage {
        AIChatMessage(text: "Hi welcome to the AI Chat App, I am your virtual assistant. How can I help you today?",isUser: false)
    }
}
