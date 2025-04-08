//
//  PostRepositoryProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import Combine

protocol PostRepositoryProtocol {
    
    func fetchPosts() -> AnyPublisher<[Post],PostErrorCallback>
}
