//
//  AccountViewModele.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import Foundation
import SwiftUI


final class AccountViewModel : ObservableObject {
    
    @Published public var sections : [SectionItem] = []
    @Published public var navigationPath = NavigationPath()
    
    
}

extension AccountViewModel{
    
    var general : [SectionItem] {
        let appearance = SectionItem(icon: "slider.vertical.3", title: "Appearance", type: .appearance)
        let notificationsAndWarnings = SectionItem(icon: "bell", title: "Notifications", type: .notifications)
        let sensors = SectionItem(icon: "antenna.radiowaves.left.and.right", title: "IoT Sensors", type: .iotSensors)
        
        return [appearance,notificationsAndWarnings,sensors]
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
