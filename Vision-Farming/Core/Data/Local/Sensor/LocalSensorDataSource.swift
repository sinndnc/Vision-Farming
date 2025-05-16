//
//  LocalSensorDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine

protocol LocalSensorDataSource {
    func deleteAll()
    func save(_ sensors: [Sensor])
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<[Sensor], Error>
}
