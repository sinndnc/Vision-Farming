//
//  CommunityViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/31/25.
//


import Foundation
import CoreML
import Combine

enum CommunityTab : String , CaseIterable {
    case trending = "Trending"
    case forYou = "For you"
    case following = "Following"
}

final class CommunityViewModel : BaseViewModel {
    
    @Published var user : User?
    @Published var posts : [Post] = []
    @Published var error : NetworkErrorCallback?
    @Published var selectedTab : CommunityTab = .trending
    
    init(rootViewModel : RootViewModel){
        super.init()
        rootViewModel.$posts
            .assign(to: &$posts)
        rootViewModel.$error
            .assign(to: &$error)
    }
    
    private func calculateTrendingScores() {
        let now = Date()
        self.posts = self.posts.map { post in
            var updatedPost = post
            let hoursSincePosted = max(1, now.timeIntervalSince(post.created_at) / 3600)
            
            let score = (Double(post.likes) * 2) +
//            (Double(post.comments) * 3) +
//            (Double(post.shares) * 5) +
            (Double(post.views) / 100) -
            (hoursSincePosted * 0.5)
            
            updatedPost.trend_score = max(0, Int(score))
            return updatedPost
        }
        
        self.posts.sorted { $0.trend_score > $1.trend_score }
    }
    
}
