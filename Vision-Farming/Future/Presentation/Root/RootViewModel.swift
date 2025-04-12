    //
//  TabViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/18/25.
//

import Foundation
import SwiftUI
import Combine

enum TabEnum : String {
    case marketPlace
    case community
    case dashboard
    case calendar
    case catalog
}

class RootViewModel: ObservableObject {
    
    @Published var selectedTab: TabEnum = .calendar
    @Published var selectedData: CategoryItem? = nil
    @Published var navigationPath = NavigationPath()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var cancellables = Set<AnyCancellable>()
    @Inject private var catalogService : CatalogRemoteServiceProtocol
    
    func navigateToTab(_ tab: TabEnum, with data: String? = nil) {
        self.selectedTab = tab
        self.navigationPath.append("ItemDetail")
        guard let data = data else { return }
        fetchCategoryItem(barcode: data.toBarCode )
    }
    
    
    func fetchCategoryItem(barcode : [String]) {
        isLoading = true
        errorMessage = nil
        catalogService.fetchCategoryItem(barcode: barcode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { item in
                self.selectedData = item
            })
            .store(in: &cancellables)
    }
    
}

extension String {
    
    var toBarCode: [String] {
        return self.split(separator: "/").compactMap{ String($0) }
    }
}
