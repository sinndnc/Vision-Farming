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
    
    var fields : [Field]
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: PreferencesConstant.user)
    }
    
}


struct Field : Codable , Hashable{
    var id : Int
    var coordinates : [GeoPoint]
}
