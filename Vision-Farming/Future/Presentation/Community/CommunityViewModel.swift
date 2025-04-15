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

final class CommunityViewModel : ObservableObject {
    
    @Published var user : User?
    @Published var myPosts: [Post] = []
    @Published var trendingPosts: [Post] = []
    @Published var recommendedPosts: [Post] = []
    @Published var selectedTab : CommunityTab = .trending
    
    private let userRepo : UserRepository
    private let postRepo : PostRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        self.userRepo = UserRepository()
        self.postRepo = PostRepository()
        
        bind()
        userRepo.start()
    }
    
    deinit{
        userRepo.stop()
        postRepo.stop()
    }
    
    func bind() {
        userRepo.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
                guard let id = user?.id else { return }
                self?.load(user_id: id, userTags: ["test"])
            }
            .store(in: &cancellables)
    }
    
    
    private func load(user_id : String, userTags: [String]) {
        postRepo.observeAll(user_id: user_id, tags: userTags)
        postRepo.$myPosts.assign(to: &$myPosts)
        postRepo.$trendingPosts.assign(to: &$trendingPosts)
        postRepo.$recommendedPosts.assign(to: &$recommendedPosts)
    }
    
}
