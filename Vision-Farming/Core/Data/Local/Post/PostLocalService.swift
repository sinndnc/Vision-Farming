//
//  PostLocalService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import Combine

final class PostLocalService : PostLocalServiceProtocol {
    
    private let cacheKey = "cached_posts"
    
    func saveToCache(_ posts: [Post]) {
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    func loadFromCache() -> [Post] {
        if let data = UserDefaults.standard.data(forKey: cacheKey),
           let posts = try? JSONDecoder().decode([Post].self, from: data) {
            return posts
        }
        return []
    }
    
}
