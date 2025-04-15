//
//  User.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import FirebaseFirestore

struct User : FirestoreEntity{
    @DocumentID var id : String?
    var name : String
    var role : String
    var email : String
    var surname : String
}
