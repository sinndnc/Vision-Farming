//
//  ProductRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import Foundation
import Combine

protocol RemoteProductDataSource {
    
    func fetch() -> AnyPublisher<[MarketProduct], Error>
    
    mutating func cancelAllCancellables()
}
