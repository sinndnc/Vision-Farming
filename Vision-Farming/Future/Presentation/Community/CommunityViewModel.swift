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
    
    @Published var user : User? = nil
    @Published var posts: [Post] = []
    @Published var errorMessage: String?
    @Published var selectedTab : CommunityTab = .trending
   
    private var cancellables = Set<AnyCancellable>()
    
    @Inject public var postRepository : PostRepositoryProtocol
    
    func getPosts() {
        postRepository.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    case .noConnection:
                        self.errorMessage = error.localizedDescription
                    default:
                        self.errorMessage = error.localizedDescription
                    }
                }
            } receiveValue: { posts in
                self.posts = posts
            }
            .store(in: &cancellables)
    }
    
}
