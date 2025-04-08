//
//  ProductRemoteServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import Foundation
import Combine

protocol ProductRemoteServiceProtocol {
    
    func fetchAllProducts() -> AnyPublisher<[Product], Error>
    
    func addProduct(_ product: Product) -> AnyPublisher<Void, Error>
    
    func updateProduct(_ product: Product) -> AnyPublisher<Void, Error>
    
    func deleteProduct(byId id: String) -> AnyPublisher<Void, Error>
    
}
