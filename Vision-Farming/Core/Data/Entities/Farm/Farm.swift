//
//  Farm.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore

struct Farm : Codable , Hashable{
    var uid : String
    var name : String
    var owner_uid : String
    var location : GeoPoint
}
