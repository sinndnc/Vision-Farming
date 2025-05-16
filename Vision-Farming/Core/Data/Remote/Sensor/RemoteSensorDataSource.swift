//
//  RemoteSensorDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Combine

protocol RemoteSensorDataSource{
    func fetch(owner_field: String) -> AnyPublisher<[Sensor], Error>
}
