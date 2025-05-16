//
//  Vision_FarmingApp.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI
import AVFoundation

@main
struct Vision_FarmingApp: App {
    
    @StateObject private var viewModel = AppearanceViewModel()
    @StateObject private var rootViewModel = DIContainer.shared.rootViewModel
    @UIApplicationDelegateAdaptor(VisionFarmingAppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            OnBoardView()
                .environmentObject(rootViewModel)
                .preferredColorScheme(viewModel.currentTheme.toColorScheme)
        }
    }
}
