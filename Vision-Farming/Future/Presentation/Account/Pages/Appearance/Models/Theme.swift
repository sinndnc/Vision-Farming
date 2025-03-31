//
//  Theme.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/24/25.
//

import Foundation
import SwiftUICore


enum Theme : String, CaseIterable  {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
}



extension Theme{
    
    var toColorScheme : ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return .none
        }
    }
}
