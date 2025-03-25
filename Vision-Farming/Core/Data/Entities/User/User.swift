//
//  User.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import Firebase
import FirebaseCore

struct User : Codable {
    
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: PreferencesConstant.user)
    }
    
}


