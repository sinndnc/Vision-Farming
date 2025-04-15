//
//  Post.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import FirebaseFirestore

struct Post : FirestoreEntity {
    @DocumentID var id: String?
    var title: String
    var content: String
    var author_id: String
    var author_name: String
    @ServerTimestamp var created_at: Date?
    @ServerTimestamp var updated_at: Date?
    var tags: [String]
    var likes_count: Int
    var comments_count: Int
}
