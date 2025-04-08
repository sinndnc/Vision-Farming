//
//  Post.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import FirebaseFirestore

struct Post: Identifiable, Codable , Hashable {
    @DocumentID var id: String? // Firestore otomatik ID
    var title: String
    var content: String
    var authorId: String
    var authorName: String
    var authorAvatar: String?
    
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    
    var category: String
    var tags: [String]
    var likesCount: Int
    var commentsCount: Int
    var isPublished: Bool
    var visibility: String // "public", "private", "followers-only"
    var images: [String]?
    var videos: [String]?
}
