//
//  ProductRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//
import Foundation
import FirebaseFirestore
import Combine

protocol ProductRepository {
    func listen(policy: CachePolicy) -> AnyPublisher<[MarketProduct], NetworkErrorCallback>
}
