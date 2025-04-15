//
//  SensorRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/14/25.
//

import Combine
import Foundation
import FirebaseFirestore

final class SensorService{
    
    let firestore: Firestore
    var listeners: [ListenerRegistration] = []
    let sensorsSubject = CurrentValueSubject<[Sensor], Never>([])
    
    init(firestore: Firestore) {
        self.firestore = firestore
    }
    
    func startListening(fields: [Field]) {
        listeners.forEach { $0.remove() }
        listeners = []
        
        var allSensors: [Sensor] = []
        for field in fields {
            let listener = firestore.collection(FirebaseConstant.sensors)
                .whereField("owner_field", isEqualTo: field.id as Any)
                .addSnapshotListener { snapshot, error in
                    allSensors.removeAll()
                    guard let documents = snapshot?.documents else { return }
                    let sensors = documents.compactMap { try? $0.data(as: Sensor.self) }
                    allSensors.append(contentsOf: sensors)
                    self.sensorsSubject.send(allSensors)
                }
            listeners.append(listener)
        }
    }
    
    func add(_ sensor: Sensor) {
        let db = Firestore.firestore()
        let sensorRef = db.collection(FirebaseConstant.sensors)
        
        do {
            try sensorRef.addDocument(from: sensor)
        } catch {
            print("Firestore ekleme hatası: \(error)")
        }
        addToCache(sensor)
    }
    
    func delete(_ sensor: Sensor) {
        let db = Firestore.firestore()
        guard let sensor_uid = sensor.id else { return }
        
        let sensorRef = db.collection(FirebaseConstant.sensors)
            .document(sensor_uid)
        
        sensorRef.delete()
        
        deleteFromCache(sensor)
    }
    
    func update(_ sensor: Sensor){
        
    }

    
    func stopListening() {
         listeners.forEach { $0.remove() }
         listeners = []
     }
    
    
    private func addToCache(_ sensor: Sensor) {
        
    }
    
    private func deleteFromCache(_ sensor: Sensor) {
        
    }
}
