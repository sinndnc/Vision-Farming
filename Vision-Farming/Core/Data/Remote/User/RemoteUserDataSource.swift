//
//  RemoteUserDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Foundation
import Combine

protocol RemoteUserDataSource{
    func fetch() -> AnyPublisher<User, NetworkErrorCallback>
}
