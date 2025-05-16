//
//  CategoryRepository.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/20/25.
//

import Foundation
import Combine
import Supabase

protocol CategoryRepository {
    
    func getAllCategories(policy : CachePolicy) -> AnyPublisher<[Category],NetworkErrorCallback>
    
    func getAllSubCategories(of category_id: String) -> AnyPublisher<[SubCategory],NetworkErrorCallback> 
}
