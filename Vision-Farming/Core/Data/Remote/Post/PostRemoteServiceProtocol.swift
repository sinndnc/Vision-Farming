//
//  PostRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//


import Foundation
import Combine

protocol PostRemoteServiceProtocol {
    
    func fetchAllPosts() -> AnyPublisher<[Post], Error>
    
    func addPost(_ post: Post) -> AnyPublisher<Void, Error>
    
    func updatePost(_ post: Post) -> AnyPublisher<Void, Error>
    
    func deletePost(byId id: String) -> AnyPublisher<Void, Error>

}
