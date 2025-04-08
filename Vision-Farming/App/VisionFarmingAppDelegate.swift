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
        
        //User
        ServiceContainer.register(type: UserRepositoryProtocol.self, UserRepository())
        ServiceContainer.register(type: UserRemoteServiceProtocol.self, UserRemoteService(auth: auth,firestore: firestore))
        //Post
        ServiceContainer.register(type: PostRepositoryProtocol.self, PostRepository())
        ServiceContainer.register(type: PostLocalServiceProtocol.self, PostLocalService())
        ServiceContainer.register(type: PostRemoteServiceProtocol.self, PostRemoteService(auth: auth,firestore: firestore))
        //Product
        ServiceContainer.register(type: ProductRepositoryProtocol.self, ProductRepository())
        ServiceContainer.register(type: ProductRemoteServiceProtocol.self, ProductRemoteService(firestore: firestore))
        //Chatbot
        ServiceContainer.register(type: ChatBotServiceProtocol.self, ChatBotService())
        //Catalog
        ServiceContainer.register(type: CatalogRemoteServiceProtocol.self, CatalogRemoteService(firestore: firestore))
        
    }

}
