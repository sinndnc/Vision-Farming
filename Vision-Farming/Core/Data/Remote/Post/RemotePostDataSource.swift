//
//  PostRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import Combine


protocol RemotePostDataSource {
    
    func fetch() -> AnyPublisher<[Post], Error>
    
    mutating func cancelAllCancellables()
}
