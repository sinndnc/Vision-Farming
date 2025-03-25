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
    @Published var selectedItem: CategoryItem? = nil
    @Published var subCategories: [SubCategory] = []
    @Published var categoryItems: [CategoryItem] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var cancellables = Set<AnyCancellable>()
    @Inject var catalogService : CatalogRemoteServiceProtocol
    
    func fetchPlants() {
        isLoading = true
        errorMessage = nil
        
        catalogService.fetchPlants()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
    }
    
    func fetchSubcategories(category: Category) {
        isLoading = true
        errorMessage = nil
        
        catalogService.fetchSubcategories(category: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print(error)
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { subCategories in
                self.subCategories = subCategories
            })
            .store(in: &cancellables)
    }
    
    func fetchSubCategoryItems(category: Category,subCategory : SubCategory) {
        isLoading = true
        errorMessage = nil
        
        catalogService.fetchSubCategoryItems(category: category, subcategory: subCategory)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { categoryItems in
                self.categoryItems = categoryItems
            })
            .store(in: &cancellables)
    }
    
   
}

