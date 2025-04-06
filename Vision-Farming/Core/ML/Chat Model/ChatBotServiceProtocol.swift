//
//  AIChatBotServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/31/25.
//

import Foundation


protocol ChatBotServiceProtocol {
    
    func getChatBotResponse(
        leafYellowing: Int,
        brownSpots: Int,
        fruitRot: Int,
        stemCracking: Int,
        leafCurling: Int,
        rootRot: Int,
        whiteMold: Int,
        blackSpotsOnFruit: Int
    ) -> String?
    
}
