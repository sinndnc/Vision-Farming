//
//  LocalUserDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Foundation
import Combine

protocol LocalUserDataSource {
    func deleteAll()
    func save(_ user: User)
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<User,NetworkErrorCallback>
}
