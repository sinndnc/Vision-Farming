//
//  LocalCropDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Foundation
import CoreData
import Combine

final class LocalCropDataSourceImpl : LocalCropDataSource{
    
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "crops_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
    func fetch() -> AnyPublisher<[Crop], Error> {
        Future { promise in
            let request: NSFetchRequest<CropEntity> = CropEntity.fetchRequest()
            do {
                let crops = try self.context.fetch(request)
                var updatedCrops : [Crop] = []
                crops.forEach { entity in
                    let model = CropMapper.toModel(entity)
                    updatedCrops.append(model)
                }
                promise(.success(updatedCrops))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(_ crops: [Crop]) {
        deleteAll()
        crops.forEach { crop in
            CropMapper.toEntity(crop, context: context)
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = CropEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
    
}
