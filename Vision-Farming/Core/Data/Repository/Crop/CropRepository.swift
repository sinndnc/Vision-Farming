//
//  CropRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Combine
import Foundation
import FirebaseFirestore

protocol CropRepository {
    func listen(owner_id: String, policy: CachePolicy) -> AnyPublisher<[Crop], NetworkErrorCallback>
}
