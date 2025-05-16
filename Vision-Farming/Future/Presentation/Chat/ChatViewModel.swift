//
//  AIChatViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/30/25.
//

import Foundation
import NaturalLanguage

final class ChatViewModel : ObservableObject {
     
    @Published var textfield : String = ""
    @Published var messages : [ChatMessage] = []
    @Published var isDocumentPickerPresented : Bool = false
    
    
    init() {
            self.messages.append(self.initalMessage)
            let text = "JBHVHDHFJS SHFBGHSDFHBG SS FGHBSFBHJGSBHJFGHS GSF BGJHBSFBGSJBHGSFHJGSBHGBSHJBFG SG JSBGBHJSBGSBHFGJ BS SJBHFGBSBGSBFGBSFDGJHSGSDBFHGJHSJHFGJSHBDFGB SJHFDGBJSHBGSHBJGBHSFBGJasfdsgdsagadfgfsdgB"
            self.messages.append(ChatMessage(text: text))
            self.messages.append(ChatMessage(text: text,isUser: true))
            self.messages.append(ChatMessage(text: text,isUser: false))
            self.messages.append(ChatMessage(text: text,isUser: true))
    }
    
    func addMessage() {
        
        if textfield.checkEmpty { return }
        analyzeSentence(textfield)
        self.messages.append(ChatMessage(text: textfield,isUser: true))
        
        self.textfield = ""

    }
    
    
    func analyzeSentence(_ sentence: String) {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = sentence
        
        tagger.enumerateTags(
            in: sentence.startIndex..<sentence.endIndex,
            unit: .word,
            scheme: .lexicalClass
        ) { tag, tokenRange in
            if let tag = tag {
                print("\(sentence[tokenRange]): \(tag.rawValue)")
            }
            return true
        }
    }
    
    
}

extension String {
    
    var checkEmpty : Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}


extension ChatViewModel {
    
    var initalMessage : ChatMessage {
        ChatMessage(
            text: "Hi welcome to the AI Chat App, I am your virtual assistant. How can I help you today?",
            isUser: false
        )
    }
}
