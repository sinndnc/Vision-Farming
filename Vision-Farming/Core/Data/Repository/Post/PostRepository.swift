//
//  PostRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import Combine

final class PostRepository : PostRepositoryProtocol{
    
    private var cancellables = Set<AnyCancellable>()
    private var errorMessage : String?

    @Inject private var remoteService : PostRemoteServiceProtocol
    @Inject private var cacheService : PostLocalServiceProtocol

    func fetchPosts() -> AnyPublisher<[Post],PostErrorCallback> {
        
        let subject = PassthroughSubject<[Post],PostErrorCallback>()
        
        remoteService.fetchAllPosts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    let cachedPosts = self.cacheService.loadFromCache()
                    subject.send(cachedPosts)
                }
            } receiveValue: { posts in
                subject.send(posts)
            }
            .store(in: &cancellables)
        
        return subject.eraseToAnyPublisher()
    }
    
}
