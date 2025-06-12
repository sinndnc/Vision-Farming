//
//  SensorHistory.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/18/25.
//

import Foundation
import FirebaseFirestore

struct SensorHistory : FirestoreEntity{
    @DocumentID var id : String?
    var value : Double
    var timestamp : Date
}
