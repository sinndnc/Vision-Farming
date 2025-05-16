//
//  LocalFarmDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import CoreData
import Combine

final class LocalFarmDataSourceImpl : LocalFarmDataSource{
    
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "farms_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
    func fetch() -> AnyPublisher<[Farm], Error> {
        Future { promise in
            let request: NSFetchRequest<FarmEntity> = FarmEntity.fetchRequest()
            do {
                let farms = try self.context.fetch(request)
                var updatedFarms : [Farm] = []
                farms.forEach { entity in
                    let model = FarmMapper.toModel(entity)
                    updatedFarms.append(model)
                }
                promise(.success(updatedFarms))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(_ farms: [Farm]) {
        deleteAll()
        farms.forEach { farm in
            FarmMapper.toEntity(farm, context: context)
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FarmEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
    
}
