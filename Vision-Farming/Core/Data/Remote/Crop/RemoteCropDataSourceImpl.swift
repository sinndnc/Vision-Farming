//
//  RemoteCropDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//

import FirebaseFirestore
import Foundation
import Combine


final class RemoteCropDataSourceImpl : RemoteCropDataSource {
    
    private let firestore : Firestore
    private let storage : StorageService
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore : Firestore,storage: StorageService) {
        self.storage = storage
        self.firestore = firestore
    }
    
    func fetch(owner_id: String) -> AnyPublisher<[Crop], Error> {
        Future { promise in
            self.firestore
                .collection(FirebaseConstant.crops)
                .whereField(FirebaseConstant.owner_id, isEqualTo: owner_id)
                .addSnapshotListener{ snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    
                    let crops = snapshot?.documents.compactMap {
                        try? $0.data(as: Crop.self)
                    } ?? []
                    
                    let publishers = crops.map { crop in
                        self.storage.downloadImage(
                            subPath: SupabaseConstant.products,
                            path: crop.name.lowercased()
                        )
                        .map { imageData -> Crop in
                            var updatedCrop = crop
                            updatedCrop.image = imageData
                            return updatedCrop
                        }
                        .eraseToAnyPublisher()
                    }
                    
                    Publishers.MergeMany(publishers)
                        .collect()
                        .sink(receiveCompletion: { completion in
                            if case .failure(let error) = completion {
                                Logger.log("Publisher failed with error: \(error)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { updatedCrops in
                            promise(.success(updatedCrops))
                        })
                        .store(in: &self.cancellable)
                }
        }
        .eraseToAnyPublisher()
    }
}
