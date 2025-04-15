//
//  CropService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Combine
import Foundation
import FirebaseFirestore


class CropService{
    
    let db : Firestore
    private var listener: ListenerRegistration?
    public let cropsSubject = CurrentValueSubject<[Crop], Never>([])
    
    init(db: Firestore) {
        self.db = db
    }
    
    func startListening(owner_id: String) {
        listener = db
            .collection(FirebaseConstant.crops)
            .whereField(FirebaseConstant.owner_id, isEqualTo: owner_id)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let docs = snapshot?.documents else { return }
                let crops = docs.compactMap { try? $0.data(as: Crop.self) }
                self?.cropsSubject.send(crops)
            }
    }
    
    func stopListening() {
        listener?.remove()
    }
    
}
