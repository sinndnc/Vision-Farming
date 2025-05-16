//
//  Vegetables.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/20/25.
//

import Foundation
import FirebaseFirestore

struct Category: FirestoreEntity {
    @DocumentID var id: String?
    var name: String
    var image : Data?
}
