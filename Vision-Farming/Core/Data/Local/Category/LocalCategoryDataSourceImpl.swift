//
//  LocalCategoryDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine
import CoreData

final class LocalCategoryDataSourceImpl: LocalCategoryDataSource {
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "categories_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
    func fetch() -> AnyPublisher<[Category], Error> {
        Future { promise in
            let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            do {
                var updatedCategory : [Category] = []
                let categories = try self.context.fetch(request)
                categories.forEach { entity in
                    let model = CategoryMapper.toModel(entity)
                    updatedCategory.append(model)
                }
                promise(.success(updatedCategory))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(_ model: [Category]) {
        deleteAll()
        model.forEach { category  in
            CategoryMapper.toEntity(category, context: context)
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
}
