//
//  CatalogViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/18/25.
//

import Foundation
import Combine

class CatalogViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    @Published var subCategories: [Category] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var cancellables = Set<AnyCancellable>()

}
