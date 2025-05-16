//
//  SubCategory.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import FirebaseFirestore
import Foundation

struct SubCategory: FirestoreEntity {
    @DocumentID var id: String?
    var name: String
    var image : Data?
}
