//
//  BaseRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation



protocol RepositoryProtocol : ObservableObject {
    associatedtype Entity: FirestoreEntity
    
    func stop()
    
    func add(_ entity: Entity)
    func update(_ entity: Entity)
    func delete(_ entity: Entity)
}
