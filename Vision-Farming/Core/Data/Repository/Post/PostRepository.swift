//
//  PostRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Combine
import Foundation
import FirebaseFirestore

protocol PostRepository {
    func listen(policy: CachePolicy) -> AnyPublisher<[Post], NetworkErrorCallback>
}
