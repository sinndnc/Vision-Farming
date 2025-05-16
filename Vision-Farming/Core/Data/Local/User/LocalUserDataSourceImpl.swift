//
//  LocalUserDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Foundation
import Combine
import CoreData

final class LocalUserDataSourceImpl : LocalUserDataSource{
    
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
    
    func fetch() -> AnyPublisher<User,NetworkErrorCallback> {
        Future { promise in
            let fetchRequest = UserEntity.fetchRequest()
            do {
                let entities = try self.context.fetch(fetchRequest)
                guard let entity = entities.first else {
                    promise(.failure(.noData))
                    Logger.log("NO USER")
                    return 
                }
                let user = UserMapper.toModel(entity)
                promise(.success(user))
            } catch {
                promise(.failure(.local(error)))
            }
        }.eraseToAnyPublisher()
    }
    
    func save(_ user: User) {
        UserMapper.toEntity(user, context: self.context)
        CoreDataStack.shared.saveContext()
        self.userDefaults.set(Date(), forKey: "user_last_updated")
       
    }
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "user_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
}
