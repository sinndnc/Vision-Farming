//
//  User.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import Firebase

struct User : Codable {
    
    var fields : [Field]
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: PreferencesConstant.user)
    }
    
}


struct Field : Codable {
    
    var coordinates : [GeoPoint]
}
