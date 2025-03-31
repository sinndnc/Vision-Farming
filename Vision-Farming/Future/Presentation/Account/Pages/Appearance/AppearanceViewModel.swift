//
//  AppearanceViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/24/25.
//

import Foundation
import SwiftUI


final class AppearanceViewModel : ObservableObject {
    
    @AppStorage("themeSetting") var themeSetting: Theme = .system
    @AppStorage("languageSetting") var languageSetting: Language = .english

    var currentTheme: Theme {
        switch themeSetting {
        case .light: return .light
        case .dark: return .dark
        default: return .system
        }
    }
    
    var currentLanguage: Language {
        switch languageSetting {
        case .english : return .english
        case .turkish : return .turkish
        case .spanish : return .spanish
        }
    }
        
    func setTheme(_ theme: Theme) {
        themeSetting = theme
        objectWillChange.send()
    }
    
    func setLanguage(_ language: Language) {
        languageSetting = language
        objectWillChange.send()
    }
}
