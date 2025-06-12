//
//  TransactionRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Foundation
import Combine

protocol TransactionRepository {
    
    func listen(for owner_id: String,policy: CachePolicy) -> AnyPublisher<[Transaction], NetworkErrorCallback>
}
