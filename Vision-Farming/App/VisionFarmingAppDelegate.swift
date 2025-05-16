//
//  VisionFarmingAppDelegate.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class VisionFarmingAppDelegate: NSObject, UIApplicationDelegate {
  
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        setupDependencyContainer()
        
        return true
    }
}

extension VisionFarmingAppDelegate  {
    
    func setupDependencyContainer() {
        FirebaseApp.configure()
        ValueTransformer.setValueTransformer(GeoPointTransformer(), forName: NSValueTransformerName(rawValue: "GeoPointTransformer"))
    }

}
