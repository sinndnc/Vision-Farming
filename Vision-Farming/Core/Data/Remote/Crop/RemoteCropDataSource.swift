//
//  RemoteProductDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//

import Combine

protocol RemoteCropDataSource {
    func fetch(owner_id: String) -> AnyPublisher<[Crop], Error>
    
    func add(_ crop: Crop)
}
