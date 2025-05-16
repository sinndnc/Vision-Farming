//
//  RemoteFieldDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine

protocol RemoteFieldDataSource {
    func fetch(owner_farm: String) -> AnyPublisher<[Field], Error>
}
