//
//  FieldCacheService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/29/25.
//

import Foundation
import CoreData
import Combine

class LocalFieldDataSourceImpl : LocalFieldDataSource {
    
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "fields_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
    func fetch() -> AnyPublisher<[Field], Error> {
        Future { promise in
            let request: NSFetchRequest<FieldEntity> = FieldEntity.fetchRequest()
            do {
                let fields = try self.context.fetch(request)
                var updatedFields : [Field] = []
                fields.forEach { entity in
                    let model = FieldMapper.toModel(entity)
                    updatedFields.append(model)
                }
                promise(.success(updatedFields))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(_ fields: [Field]) {
        deleteAll()
        fields.forEach { field in
            FieldMapper.toEntity(field, context: context)
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FieldEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
    
}
