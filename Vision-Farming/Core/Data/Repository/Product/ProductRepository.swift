//
//  ProductRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//
import Foundation
import FirebaseFirestore
import Combine

class ProductRepository : ProductRepositoryProtocol {
    
    private let db = Firestore.firestore()
    private let collection = "products"
    
    func getAllProducts() -> AnyPublisher<[MarketProduct], Error> {
        let ref = db.collection(collection)
        return Future { promise in
            ref.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let products = snapshot?.documents.compactMap { try? $0.data(as: MarketProduct.self) } ?? []
                    promise(.success(products))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addProduct(_ product: MarketProduct) -> AnyPublisher<Void, Error> {
        let ref = db.collection(collection).document(product.id ?? UUID().uuidString)
        return Future { promise in
            do {
                try ref.setData(from: product) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateProduct(_ product: MarketProduct) -> AnyPublisher<Void, Error> {
        guard let id = product.id else {
            return Fail(error: NSError(domain: "ProductRepository", code: 0, userInfo: [NSLocalizedDescriptionKey: "Product ID is missing"])).eraseToAnyPublisher()
        }
        let ref = db.collection(collection).document(id)
        return Future { promise in
            do {
                try ref.setData(from: product, merge: true) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func deleteProduct(byId id: String) -> AnyPublisher<Void, Error> {
        let ref = db.collection(collection).document(id)
        return Future { promise in
            ref.delete { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
 
}
