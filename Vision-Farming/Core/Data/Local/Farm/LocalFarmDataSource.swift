//
//  LocalFarmDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import Combine

protocol LocalFarmDataSource {
    func deleteAll()
    func save(_ farms: [Farm])
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<[Farm], Error>
}
