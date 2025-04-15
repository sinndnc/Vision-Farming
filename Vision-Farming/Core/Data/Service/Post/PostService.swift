//
//  PostRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class PostService{
    
    private let db = Firestore.firestore()
    
    func listenToPosts(query: Query, onUpdate: @escaping ([Post]) -> Void) -> ListenerRegistration {
        query.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap { try? $0.data(as: Post.self) }
            onUpdate(posts)
        }
    }
    
    func queryForMyPosts(user_id: String) -> Query {
        db.collection(FirebaseConstant.posts)
            .whereField(FirebaseConstant.author_id, isEqualTo: user_id)
            .order(by: FirebaseConstant.created_at, descending: true)
    }
    
    func queryForTrendingPosts() -> Query {
        db.collection(FirebaseConstant.posts)
            .order(by: "likes", descending: true)
            .limit(to: 10)
    }
    
    func queryForRecommendedPosts(user_id: String, tags: [String]) -> Query {
        db.collection(FirebaseConstant.posts)
            .whereField("tags", arrayContainsAny: tags)
            .order(by: "timestamp", descending: true)
    }
    
}
