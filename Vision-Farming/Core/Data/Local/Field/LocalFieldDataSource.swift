//
//  LocalFieldDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Combine

protocol LocalFieldDataSource {
    func deleteAll()
    func save(_ fields: [Field])
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<[Field], Error>
}
