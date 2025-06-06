//
//  FirestoreEntity.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import FirebaseFirestore

protocol FirestoreEntity: Codable ,Hashable, Identifiable {
    var id: String? { get }
}
