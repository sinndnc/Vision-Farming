//
//  FieldService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import FirebaseFirestore
import CoreData

class FieldService {
    
    private let db = Firestore.firestore()
    private var listeners: [ListenerRegistration] = []
    let fieldsSubject = CurrentValueSubject<[Field], Never>([])
    
    func startListening(farms: [Farm]) {
        listeners.forEach { $0.remove() }
        listeners = []
        
        var allFields: [Field] = []
        
        for farm in farms {
            let listener = db
                .collection(FirebaseConstant.fields)
                .whereField(FirebaseConstant.owner_farm, isEqualTo: farm.id as Any)
                .addSnapshotListener { [weak self] snapshot, error in
                    allFields.removeAll()
                    guard let docs = snapshot?.documents else { return }
                    let fields = docs.compactMap { try? $0.data(as: Field.self) }
                    allFields.append(contentsOf: fields)
                    self?.fieldsSubject.send(allFields)
                }
            listeners.append(listener)
        }
    }
    
    func add(_ field: Field) {
        let db = Firestore.firestore()
        let fieldRef = db.collection(FirebaseConstant.fields)
        
        do {
            try fieldRef.addDocument(from: field)
        } catch {
            print("Firestore ekleme hatası: \(error)")
        }
        addToCache()
    }
    
    func delete(_ field: Field) {
        let db = Firestore.firestore()
        guard let field_id = field.id else { return }
        let fieldRef = db.collection(FirebaseConstant.fields)
            .document(field_id)
        
        fieldRef.delete()
        
        deleteFromCache(field)
    }
    
    func stopListening() {
        listeners.forEach { $0.remove() }
        listeners = []
    }
    
    private func deleteFromCache(_ field: Field) {
//        let request: NSFetchRequest<FieldEntity> = FieldEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", field.id)
//        
//        if let result = try? context.fetch(request), let entity = result.first {
//            context.delete(entity)
//            try? context.save()
//        }
    }
    
    private func addToCache() {
//        let entity = FieldEntity(context: context)
//        entity.id = field.id
//        entity.name = field.name
//        entity.farmId = field.farmId
//        
//        try? context.save()
    }
}
