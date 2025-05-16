//
//  User.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import FirebaseFirestore

public struct User : FirestoreEntity {
    @DocumentID public var id: String?
    var name: String
    var surname: String
    var email: String
    var role: String
    var image: Data?
}
