//
//  ChatBotService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/31/25.
//

import Foundation
import CoreML

public class ChatBotService : ChatBotServiceProtocol {
    
    func getChatBotResponse(
        leafYellowing: Int,
        brownSpots: Int,
        fruitRot: Int,
        stemCracking: Int,
        leafCurling: Int,
        rootRot: Int,
        whiteMold: Int,
        blackSpotsOnFruit: Int
    ) -> String? {
        
        do {
            let model = try ChatBotClassifier(configuration: .init())
            let input = ChatBotClassifierInput(
                Leaf_Yellowing: Int64(leafYellowing),
                Brown_Spots: Int64(brownSpots),
                Fruit_Rot: Int64(fruitRot),
                Stem_Cracking: Int64(stemCracking),
                Leaf_Curling: Int64(leafCurling),
                Root_Rot: Int64(rootRot),
                White_Mold: Int64(whiteMold),
                Black_Spots_on_Fruit: Int64(blackSpotsOnFruit)
            )
            let output = try model.prediction(input: input)
            return output.Disease
         } catch {
             print("Model tahmin yaparken hata oluştu: \(error)")
             return nil
         }
    }
    
    
}
