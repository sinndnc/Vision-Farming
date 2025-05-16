//
//  Post 2.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/16/25.
//


import Foundation
import FirebaseFirestore

struct Post: FirestoreEntity {
    @DocumentID var id: String?
    var title: String
    var content: String
//    var category: String
    var tags: [String]
    var author_id: String
    var author_name: String
//    var imageURLs: [String]?
//    var location: GeoPoint?
    var created_at: Date
    var likes: Int
    var trend_score: Int
    var views: Int
    var is_following: Bool
//    var comments: [Comment]
//    var isActive: Bool
    
    // Ek özellikler:
//    var shareCount: Int
//    var poll: Poll?
}

struct Comment: Identifiable, Codable {
    var id: String
    var user_id: String
    var userName: String
    var content: String
    var createdAt: Date
}

struct Poll: Codable {
    var question: String
    var options: [String: Int]
}
