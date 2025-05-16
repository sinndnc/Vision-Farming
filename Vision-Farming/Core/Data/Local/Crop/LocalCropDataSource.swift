//
//  LocalProductDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//

import Combine


protocol LocalCropDataSource {
    func deleteAll()
    func save(_ crops: [Crop])
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<[Crop], Error>
}
