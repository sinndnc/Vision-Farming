//
//  LocalSensorDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine
import CoreData

final class LocalSensorDataSourceImpl : LocalSensorDataSource{
    
    private let context = CoreDataStack.shared.context
    private let userDefaults = UserDefaults.standard
    
    func isCacheExpired(ttl: Int) -> Bool {
        guard let lastUpdated = userDefaults.object(forKey: "sensors_last_updated") as? Date else {
            return true
        }
        return Date().timeIntervalSince(lastUpdated) > TimeInterval(ttl)
    }
    
    func fetch() -> AnyPublisher<[Sensor], Error> {
        Future { promise in
            let request: NSFetchRequest<SensorEntity> = SensorEntity.fetchRequest()
            do {
                let sensors = try self.context.fetch(request)
                var updatedSensors : [Sensor] = []
                sensors.forEach { entity in
                    let model = SensorMapper.toModel(entity)
                    updatedSensors.append(model)
                }
                promise(.success(updatedSensors))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(_ sensors: [Sensor]) {
        deleteAll()
        sensors.forEach { sensor in
            SensorMapper.toEntity(sensor, context: context)
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = SensorEntity.fetchRequest()
        let batchDelete1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        try? context.execute(batchDelete1)
    }
    
}
