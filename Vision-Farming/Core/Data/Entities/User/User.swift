//
//  User.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import Firebase
import FirebaseCore

struct User : Codable , Hashable {
    var uid : String
    var name : String
    var role : String
    var email : String
    var surname : String
    var farms : [Farm] = []
    var fields : [ Farm : [Field] ] = [:]
    var sensors : [ Field : [Sensor] ] = [:]
}
