//
//  SensorRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import Combine
import FirebaseFirestore
import Foundation
import CoreData


final class SensorRepository: RepositoryProtocol {
    
    typealias Entity = Sensor

    @Published var sensors : [Sensor] = []
    
    private let service: SensorService
    private var cancellable: AnyCancellable?
    //    private let context: NSManagedObjectContext
    
    init(service: SensorService = SensorService(firestore: .firestore())) {
        self.service = service
//        self.context = context
    }

    func start(fields : [Field]) {
        loadLocalSensors()
        
        cancellable = service.sensorsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sensors in
                self?.sensors = sensors
                self?.saveSensorsToCoreData(sensors)
            }
        
        service.startListening(fields: fields)
    }
    
    func add(_ sensor : Sensor){
        service.add(sensor)
    }
    
    func delete(_ sensor : Sensor){
        service.delete(sensor)
    }
    
    func update(_ sensor: Sensor) {
        
    }
    
    func stop() {
        service.stopListening()
        cancellable?.cancel()
    }

    private func loadLocalSensors() {
//        let request: NSFetchRequest<SensorEntity> = SensorEntity.fetchRequest()
//        if let results = try? context.fetch(request) {
//            self.sensors = results.map {
//                Sensor(id: $0.id, type: $0.type ?? "", value: $0.value, fieldId: $0.fieldId ?? "")
//            }
//        }
    }

    private func saveSensorsToCoreData(_ sensors: [Sensor]) {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SensorEntity.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        _ = try? context.execute(deleteRequest)
//
//        for sensor in sensors {
//            let entity = SensorEntity(context: context)
//            entity.id = sensor.id
//            entity.type = sensor.type
//            entity.value = sensor.value
//            entity.fieldId = sensor.fieldId
//        }
//
//        try? context.save()
    }
}

