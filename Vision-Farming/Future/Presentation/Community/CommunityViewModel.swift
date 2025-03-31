//
//  CommunityViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/31/25.
//


import Foundation
import CoreML

enum CommunityTab : String , CaseIterable {
    case trending = "Trending"
    case forYou = "For you"
    case following = "Following"
}

class CommunityViewModel : ObservableObject {
    
    @Published var user : User? = nil
    @Published var selectedTab : CommunityTab = .trending
    
    @Inject private var userRepository : UserRepositoryProtocol
    
//    func predictDisease(features: [String: Double]) -> String? {
//        do {
//            let model = try MyTabularClassifier(configuration: MLModelConfiguration())  // Model adını kendi modeline göre değiştir.
//
//            let input =  MyTabularClassifierInput(
//                Temperature: features["temperature"] ?? 0.0,
//                Humidity: features["humidity"] ?? 0.0,
//                Soil_pH: features["soilPH"] ?? 0.0,
//                Soil_Moisture: features["soilMoisture"] ?? 0.0,
//                Plant_Type: Int64(features["plantType"] ?? 0)
//            )
//
//            let prediction = try model.prediction(input: input)
//            return prediction.DiseaseProbability.debugDescription  // Modelin çıkış değişkenine bağlı olarak burayı değiştir.
//
//        } catch {
//            print("Tahmin yapılamadı: \(error)")
//            return nil
//        }
//    }
    
}
