//
//  FarmRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import CoreData

class FarmRepository: ObservableObject {
    
    @Published var farms: [Farm] = []
    
    private let service: FarmService
    private var cancellable: AnyCancellable?
    
    init(service: FarmService = FarmService()) {
        self.service = service
    }

    func start(owner_id: String) {
//        loadLocalFarms()
        cancellable = service.farmsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] farms in
                self?.farms = farms
//                self?.saveFarmsToCoreData(farms)
            }
        
        service.startListening(owner_id: owner_id)
    }

    func stop() {
        service.stopListening()
        cancellable?.cancel()
    }

//    private func loadLocalFarms() {
//        let request: NSFetchRequest<FarmEntity> = FarmEntity.fetchRequest()
//        if let results = try? context.fetch(request) {
//            self.farms = results.map { Farm(id: $0.id, name: $0.name ?? "") }
//        }
//    }
//
//    private func saveFarmsToCoreData(_ farms: [Farm]) {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FarmEntity.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        _ = try? context.execute(deleteRequest)
//
//        for farm in farms {
//            let entity = FarmEntity(context: context)
//            entity.id = farm.id
//            entity.name = farm.name
//        }
//
//        try? context.save()
//    }
}
