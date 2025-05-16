//
//  RemoteCategoryDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import Foundation
import Combine

protocol RemoteCategoryDataSource{
    
    func fetchCategories() -> AnyPublisher<[Category], Error>
    
}
