//
//  PostRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Combine
import Foundation
import FirebaseFirestore

final class PostRepository {
    
    private let service = PostService()
    private var cancellables = Set<AnyCancellable>()
    private var listeners: [ListenerRegistration] = []
    
    @Published var myPosts: [Post] = []
    @Published var trendingPosts: [Post] = []
    @Published var recommendedPosts: [Post] = []
    
    func observeAll(user_id: String, tags: [String]) {
        listeners.forEach { $0.remove() }
        listeners.removeAll()
        
        let myListener = service.listenToPosts(query: service.queryForMyPosts(user_id: user_id)) { [weak self] posts in
            self?.myPosts = posts
        }
        
        let trendingListener = service.listenToPosts(query: service.queryForTrendingPosts()) { [weak self] posts in
            self?.trendingPosts = posts
        }
        
        let recommendedListener = service.listenToPosts(query: service.queryForRecommendedPosts(user_id: user_id, tags: tags)) { [weak self] posts in
            self?.recommendedPosts = posts
        }
        listeners = [myListener, trendingListener, recommendedListener]
    }
    
    func stop(){
        listeners.forEach { $0.remove() }
    }
    
    deinit {
        listeners.forEach { $0.remove() }
    }

}
