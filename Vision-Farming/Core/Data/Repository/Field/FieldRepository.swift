//
//  FieldRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import CoreData

protocol FieldRepository{
    func listen(owner_farm: String, policy: CachePolicy) -> AnyPublisher<[Field], NetworkErrorCallback>
}
