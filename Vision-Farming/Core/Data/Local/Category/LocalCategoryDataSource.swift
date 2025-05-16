//
//  LocalCategoryDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine

protocol LocalCategoryDataSource{
    
    func deleteAll()
    func save(_ categories: [Category])
    func isCacheExpired(ttl: Int) -> Bool
    func fetch() -> AnyPublisher<[Category], Error>
}
