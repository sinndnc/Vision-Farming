//
//  FarmService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Foundation
import Combine
import FirebaseFirestore

class FarmService {
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    let farmsSubject = CurrentValueSubject<[Farm], Never>([])
    
    func startListening(owner_id: String) {
        listener = db
            .collection(FirebaseConstant.farms)
            .whereField(FirebaseConstant.owner_id, isEqualTo: owner_id)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let docs = snapshot?.documents else { return }
                let farms = docs.compactMap { try? $0.data(as: Farm.self) }
                self?.farmsSubject.send(farms)
            }
    }
    
    func stopListening() {
        listener?.remove()
    }
}
