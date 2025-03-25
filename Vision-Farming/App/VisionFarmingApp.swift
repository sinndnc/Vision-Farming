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
    
    @UIApplicationDelegateAdaptor(VisionFarmingAppDelegate.self) var delegate
    @StateObject private var viewModel = AppearanceViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(viewModel.currentTheme.toColorScheme)
        }
    }
}
