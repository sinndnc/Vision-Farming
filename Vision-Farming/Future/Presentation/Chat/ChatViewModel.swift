//
//  AIChatViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/30/25.
//

import Foundation

final class ChatViewModel : ObservableObject {
     
    @Published var textfield : String = ""
    @Published var messages : [ChatMessage] = []
    @Published var isDocumentPickerPresented : Bool = false
    
    @Inject var aIChatBotService : ChatBotServiceProtocol
    
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
        
        self.messages.append(ChatMessage(text: textfield,isUser: true))
        self.textfield = ""
        
        sendMessageToService()
    }
    
    func sendMessageToService(){
        let (leafYellowing, brownSpots, fruitRot, stemCracking, leafCurling, rootRot, whiteMold, blackSpotsOnFruit) = convertTextToFeatures(text: textfield)
        
        let response = aIChatBotService.getChatBotResponse(
            leafYellowing: leafYellowing,
            brownSpots: brownSpots,
            fruitRot: fruitRot,
            stemCracking: stemCracking,
            leafCurling: leafCurling,
            rootRot: rootRot,
            whiteMold: whiteMold,
            blackSpotsOnFruit: blackSpotsOnFruit
        )
        
        if let response = response {
            self.messages.append(ChatMessage(text: response, isUser: false))
           
        }
    }
    
    func convertTextToFeatures(text: String) -> (Int, Int, Int, Int, Int, Int, Int, Int) {
        
        let lowercasedText = text.lowercased()
        
        let leafYellowing = lowercasedText.contains("yaprak sararması") ? 1 : 0
        let brownSpots = lowercasedText.contains("kahverengi lekeler") ? 1 : 0
        let fruitRot = lowercasedText.contains("meyve çürüğü") ? 1 : 0
        let stemCracking = lowercasedText.contains("gövde çatlaması") ? 1 : 0
        let leafCurling = lowercasedText.contains("yaprak kıvrılması") ? 1 : 0
        let rootRot = lowercasedText.contains("kök çürümesi") ? 1 : 0
        let whiteMold = lowercasedText.contains("beyaz küf") ? 1 : 0
        let blackSpotsOnFruit = lowercasedText.contains("meyvede siyah lekeler") ? 1 : 0
        
        return (leafYellowing, brownSpots, fruitRot, stemCracking, leafCurling, rootRot, whiteMold, blackSpotsOnFruit)
    }
    
}

extension String {
    
    var checkEmpty : Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}


extension ChatViewModel {
    
    var initalMessage : ChatMessage {
        ChatMessage(text: "Hi welcome to the AI Chat App, I am your virtual assistant. How can I help you today?",isUser: false)
    }
}
