//
//  PostRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import FirebaseFirestore
import Foundation
import Combine

final class RemotePostDataSourceImpl : RemotePostDataSource{
    private let firestore : Firestore
    private let storage : StorageService
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore: Firestore, storage: StorageService) {
        self.firestore = firestore
        self.storage = storage
    }
    
    func fetch() -> AnyPublisher<[Post], any Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.posts)
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    
                    let posts = snapshot?.documents.compactMap {
                        try? $0.data(as: Post.self)
                    } ?? []
                    
                    promise(.success(posts))
//                    let publishers = products.map { product in
//                        self.storage.downloadImage(
//                            subPath: SupabaseConstant.products,
//                            path: product.id.lowercased()
//                        )
//                        .map { imageData -> MarketProduct in
//                            var updatedProduct = product
//                            updatedProduct.image = imageData
//                            return updatedProduct
//                        }
//                        .eraseToAnyPublisher()
//                    }
//                    
//                    Publishers.MergeMany(publishers)
//                        .collect()
//                        .sink(receiveCompletion: { completion in
//                            if case .failure(let error) = completion {
//                                Logger.log("Publisher failed with error: \(error)")
//                                promise(.failure(error))
//                            }
//                        }, receiveValue: { updatedProducts in
//                            promise(.success(updatedProducts))
//                        })
//                        .store(in: &self.cancellable)
                }
        }
        .eraseToAnyPublisher()
    }
    
    func cancelAllCancellables() {
        cancellable.removeAll()
    }
    
    
}
