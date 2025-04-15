//
//  CatalogRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/20/25.
//

import Combine
import Foundation
import FirebaseFirestore


protocol CatalogRemoteServiceProtocol {
    
    var firestore : Firestore { get }
    
    func fetchCategories() -> AnyPublisher<[Category], Error>
    
    func fetchSubcategories(category: Category) -> AnyPublisher<[SubCategory], Error>
    
    func fetchCategoryItem(barcode: [String]) -> AnyPublisher<CategoryItem, any Error>
        
    func fetchSubCategoryItems(category: Category,subcategory : SubCategory) -> AnyPublisher<[CategoryItem], Error>
    
}
