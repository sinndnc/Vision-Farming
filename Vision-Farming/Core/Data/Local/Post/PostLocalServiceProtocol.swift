//
//  PostLocalServiceProtocol.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import Combine

protocol PostLocalServiceProtocol {
    
    func loadFromCache() -> [Post]
    
    func saveToCache(_ posts: [Post])
    
}
