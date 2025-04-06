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
    
    
}
