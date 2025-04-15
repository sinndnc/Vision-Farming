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
    var notes : String
    var owner_uid : String
    var planted_date : Date
    var expected_harvest_date : Date
}
