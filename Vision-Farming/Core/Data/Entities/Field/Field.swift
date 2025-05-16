//
//  Field.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore
import CoreLocation


struct Field : FirestoreEntity {
    @DocumentID var id : String?
    var name : String
    var owner_farm : String
    var coordinates : [GeoPoint]
    var harvest_date : Date
    var planted_date : Date
}
