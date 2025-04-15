//
//  CropRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import Combine
import Foundation
import FirebaseFirestore

final class CropRepository : RepositoryProtocol {
    typealias Entity = Crop
    
    private let service : CropService
    private var cancellable: AnyCancellable?
    
    @Published var crops : [Crop] = []
    
    init(){
        self.service = CropService(db: .firestore())
    }
    
    func start(owner_id : String) {
        cancellable = service.cropsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] crops in
                self?.crops = crops
            }
        service.startListening(owner_id: owner_id)
    }
    
    func add(_ entity: Crop) {
        
    }
    
    func update(_ entity: Crop) {
        
    }
    
    func delete(_ entity: Crop) {
        
    }
    
    func stop() {
        service.stopListening()
        cancellable?.cancel()
    }
    
}
