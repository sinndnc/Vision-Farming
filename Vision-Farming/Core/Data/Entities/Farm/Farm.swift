//
//  Farm.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore

struct Farm : FirestoreEntity {
    @DocumentID var id : String?
    var name : String
    var owner_id : String
    var location : GeoPoint
}
