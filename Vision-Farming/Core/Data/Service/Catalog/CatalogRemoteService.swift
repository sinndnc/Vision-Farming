//
//  CatalogRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/20/25.
//

import Foundation
import Combine
import FirebaseFirestore

final class CatalogRemoteService : CatalogRemoteServiceProtocol {
    
    let firestore : Firestore
    
    init(firestore: Firestore) {
        self.firestore = firestore
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        let subject = PassthroughSubject<[Category], Error>()
        
        firestore.collection("PLANTS").getDocuments { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            do{
                let category = try snapshot?.documents.compactMap{ document -> Category? in
                    try document.data(as: Category.self)
                }
                subject.send(category!)
                subject.send(completion: .finished)
            }
            catch{
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    
    func fetchSubcategories(category: Category) -> AnyPublisher<[SubCategory], Error> {
        let subject = PassthroughSubject<[SubCategory], Error>()
        
        firestore.collection("PLANTS").document(category.id).collection("sub_categories").getDocuments { snapshot, error in
            if let error = error {
                
                subject.send(completion: .failure(error))
                return
            }
            do{
                let subCategories = try snapshot?.documents.compactMap{ document -> SubCategory? in
                    try document.data(as: SubCategory.self)
                } ?? []
                subject.send(subCategories)
                subject.send(completion: .finished)
            }
            catch{
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func fetchSubCategoryItems(category: Category, subcategory: SubCategory) -> AnyPublisher<[CategoryItem], any Error> {
        let subject = PassthroughSubject<[CategoryItem], Error>()
        
        firestore.collection("PLANTS").document(category.id).collection("sub_categories").document(subcategory.id).collection("sub_category_items").getDocuments { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            do {
                let item = try snapshot?.documents.compactMap{ document -> CategoryItem? in
                    try document.data(as: CategoryItem.self)
                } ?? []
                subject.send(item)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    
    func fetchCategoryItem(barcode: [String]) -> AnyPublisher<CategoryItem, any Error> {
        let subject = PassthroughSubject<CategoryItem, Error>()
        
        firestore.collection("PLANTS")
            .document(barcode[0])
            .collection("sub_categories")
            .document(barcode[1])
            .collection("sub_category_items")
            .document(barcode[2])
            .getDocument { document, error in
                if let error = error {
                    subject.send(completion: .failure(error))
                    return
                }
                
                do {
                    guard let document = document else { return }
                    let item = try document.data(as: CategoryItem.self)
                    subject.send(item)
                    subject.send(completion: .finished)
                } catch {
                    subject.send(completion: .failure(error))
                }
            }
        return subject.eraseToAnyPublisher()
    }
}
