//
//  Crop.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import Foundation
import FirebaseFirestore

struct Crop : FirestoreEntity{
    @DocumentID var id : String?
    var name : String
    var image : Data?
    var notes : String
    var owner_id : String
    var planted_date : Date
    var coordinates : [GeoPoint]
    var expected_harvest_date : Date
}
