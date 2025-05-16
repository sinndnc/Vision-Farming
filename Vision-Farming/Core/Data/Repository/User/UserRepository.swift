//
//  UserRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserRepository{
    func listen(policy: CachePolicy) -> AnyPublisher<User?, NetworkErrorCallback>
}
