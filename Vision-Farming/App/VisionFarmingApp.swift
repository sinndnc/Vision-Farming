//
//  Vision_FarmingApp.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import SwiftUI

@main
struct Vision_FarmingApp: App {
    
    @UIApplicationDelegateAdaptor(VisionFarmingAppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
