//
//  AccountViewModele.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import Foundation
import SwiftUI
import FirebaseAuth


final class AccountViewModel : ObservableObject {
    
    @Published public var farms : [Farm] = []
    @Published public var fields : [Farm : [Field]] = [:]
    @Published public var sensors : [Field : [Sensor]] = [:]
    @Published public var sections : [SectionItem] = []
    @Published public var navigationPath = NavigationPath()
    
    @Inject  var userRepository : UserRepositoryProtocol
    
    func getUser() async -> User {
        let result = await userRepository.fetch()
        switch result {
        case .success(let user):
            return user
        case .failure(_):
            return User(uid: "", name: "", role: "", email: "", surname: "")
        }
    }
    
    func activeSensors(_ sensors : [Sensor]) -> Int {
        sensors.filter({$0.status == "active"}).count
    }
    
   
}

extension AccountViewModel{
    
    var general : [SectionItem] {
        let myCrops = SectionItem(icon: "leaf", title: "My Crops", type: .myCrops)
        let myFields = SectionItem(icon: "mountain.2", title: "My Fields", type: .myFields)
        let appearance = SectionItem(icon: "slider.vertical.3", title: "Appearance", type: .appearance)
        let notificationsAndWarnings = SectionItem(icon: "bell", title: "Notifications", type: .notifications)
        let sensors = SectionItem(icon: "antenna.radiowaves.left.and.right", title: "IoT Sensors", type: .iotSensors)
        
        return [myCrops,myFields,sensors,appearance,notificationsAndWarnings]
    }
    
    var data : [SectionItem] {
        let trackingAndManagement = SectionItem(icon: "list.bullet.clipboard", title: "Tracking Management", type: .tracking)
        let blockchainIntegration = SectionItem(icon: "cube.transparent", title: "Blockchain Integration", type: .blockchain)
        let cooperativeAndTeamManagement = SectionItem(icon: "person.3", title: "Cooperative Team Management", type: .cooperative)
        let supplyChainManagement = SectionItem(icon: "truck.box", title: "Supply Chain Management", type: .supplyChain)
        
        return [blockchainIntegration,trackingAndManagement,cooperativeAndTeamManagement,supplyChainManagement]
    }
    
    var ai : [SectionItem] {
        let recommendationsandAnalysis = SectionItem(icon: "brain.filled.head.profile", title: "Recommendations and Analysis", type: .recommendations)
        let smartAlertsAndAssistant = SectionItem(icon: "apple.intelligence", title: "Smart Alerts and Voice Assistant", type: .smartAlert)
        return [recommendationsandAnalysis,smartAlertsAndAssistant]
    }
    
     var about : [SectionItem] {
         let termsAndconditions = SectionItem(icon: "doc.fill", title: "Terms & Conditions",type: .terms)
         let privacyAndPolicy = SectionItem(icon: "hand.raised.fill", title: "Privacy & Policy",type: .privacy)
        let aboutUs = SectionItem(icon: "info.circle", title: "About Us",type: .aboutUs)
        return [termsAndconditions,privacyAndPolicy,aboutUs]
    }
    
}
