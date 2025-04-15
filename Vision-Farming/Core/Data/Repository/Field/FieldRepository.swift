//
//  FieldRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import CoreData


class FieldRepository: RepositoryProtocol {
    typealias Entity = Field
    
    @Published var fields: [Field] = []
    
    private let service: FieldService
    private var cancellable: AnyCancellable?

    init(service: FieldService = FieldService()) {
        self.service = service
    }

    func start(farms: [Farm]) {
//        loadLocalFields()
        
        cancellable = service.fieldsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fields in
                self?.fields = fields
//                self?.saveFieldsToCoreData(fields)
            }
        service.startListening(farms: farms)
    }
    
    func add(_ field : Field){
        service.add(field)
    }
    
    func update(_ entity: Field) {
        
    }
    
    func delete(_ field : Field){
        
    }

    func stop() {
        service.stopListening()
        cancellable?.cancel()
    }

//    private func loadLocalFields() {
//        let request: NSFetchRequest<FieldEntity> = FieldEntity.fetchRequest()
//        if let results = try? context.fetch(request) {
//            self.fields = results.map { Field(id: $0.id, name: $0.name ?? "", farmId: $0.farmId ?? "") }
//        }
//    }
//
//    private func saveFieldsToCoreData(_ fields: [Field]) {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FieldEntity.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        _ = try? context.execute(deleteRequest)
//
//        for field in fields {
//            let entity = FieldEntity(context: context)
//            entity.id = field.id
//            entity.name = field.name
//            entity.farmId = field.farmId
//        }
//
//        try? context.save()
//    }
}
