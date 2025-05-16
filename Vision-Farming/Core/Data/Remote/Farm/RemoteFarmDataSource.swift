//
//  RemoteFarmDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import Combine


protocol RemoteFarmDataSource {
    func fetch(owner_id: String) -> AnyPublisher<[Farm], Error>
}
