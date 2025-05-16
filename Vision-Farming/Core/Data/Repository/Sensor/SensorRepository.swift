//
//  SensorRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import Combine
import FirebaseFirestore
import Foundation
import CoreData


protocol SensorRepository{
    func listen(owner_field: String, policy: CachePolicy) -> AnyPublisher<[Sensor], NetworkErrorCallback>
}
