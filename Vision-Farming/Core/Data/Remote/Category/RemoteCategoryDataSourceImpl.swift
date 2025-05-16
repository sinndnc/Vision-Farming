//
//  RemoteCategoryDataSourceImpl.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import FirebaseFirestore
import Foundation
import Combine

final class RemoteCategoryDataSourceImpl : RemoteCategoryDataSource {
    private let firestore : Firestore
    private let storage : StorageService
    private var cancellable = Set<AnyCancellable>()
    
    init(firestore: Firestore, storage: StorageService) {
        self.firestore = firestore
        self.storage = storage
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.categories)
                .addSnapshotListener { snapshot, error in
                    if let error = error{
                        Logger.log("ERROR: \(error)")
                        promise(.failure(error))
                    }
                    
                    let categories = snapshot?.documents.compactMap { try? $0.data(as: Category.self) } ?? []
                    
                    let publishers = categories.map { category in
                        self.storage.downloadImage(
                            subPath: SupabaseConstant.categories,
                            path: category.name.lowercased()
                        )
                        .map { imageData -> Category in
                            var updatedCategory = category
                            updatedCategory.image = imageData
                            return updatedCategory
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
                        }, receiveValue: { updatedCategories in
                            promise(.success(updatedCategories))
                        })
                        .store(in: &self.cancellable)
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchSubCategories(category_id: String) -> AnyPublisher<[SubCategory], Error> {
        Future{ promise in
            self.firestore
                .collection(FirebaseConstant.categories)
                .document(category_id)
                .addSnapshotListener { snapshot, error in
                    
                }
        }
        .eraseToAnyPublisher()
    }
    
}
