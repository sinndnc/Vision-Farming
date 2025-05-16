//
//  FarmRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import CoreData


protocol FarmRepository {
    func listen(owner_id: String, policy: CachePolicy) -> AnyPublisher<[Farm], NetworkErrorCallback>
}

