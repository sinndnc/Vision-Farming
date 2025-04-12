//
//  Field.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore


struct Field : Codable,Hashable{
    var uid : String
    var name : String
    var coordinates : [String]
    var harvest_date : Date?
    var planted_date : Date?
}
