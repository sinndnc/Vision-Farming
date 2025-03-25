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
        
        let auth = FirebaseAuth.Auth.auth()
        let firestore = Firestore.firestore()
        
        ServiceContainer.register(type: UserRepositoryProtocol.self, UserRepository())
        ServiceContainer.register(type: UserRemoteServiceProtocol.self, UserRemoteService(auth: auth,firestore: firestore))
        
        ServiceContainer.register(type: CatalogRemoteServiceProtocol.self, CatalogRemoteService(firestore: firestore))
        
    }

}
