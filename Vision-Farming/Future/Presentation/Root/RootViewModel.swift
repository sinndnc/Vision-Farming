    //
//  TabViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/18/25.
//

import SwiftUI
import Combine
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore

enum TabEnum : String {
    case marketPlace
    case community
    case dashboard
    case calendar
    case catalog
}

class RootViewModel: ObservableObject{
    
    @Published public var user : User?
    @Published public var farms: [Farm] = []
    @Published public var crops : [Crop] = []
    @Published public var posts : [Post] = []
    @Published public var fields: [Field] = []
    @Published public var sensors: [Sensor] = []
    @Published public var products: [MarketProduct] = []
    @Published public var error: Error?

    @Published public var sections : [SectionItem] = []
    @Published public var selectedTab : TabEnum = .dashboard
    
    @Published public var accNavigationPath = NavigationPath()
    @Published public var navigationPath : NavigationPath = NavigationPath()
    
    private let loader: DataLoader
    private var cancellables = Set<AnyCancellable>()
    
    init(loader: DataLoader) {
        self.loader = loader
        loadAndListenUserData()
        loadAndListenProductsAndPostsData()
    }
    
    private func loadAndListenUserData() {
        loader.loadAndListenUserData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] user, crops, farms, fields ,sensors in
                self?.user = user
                self?.crops = crops
                self?.farms = farms
                self?.fields = fields
                self?.sensors = sensors
            }
            .store(in: &cancellables)
    }
    
    private func loadAndListenProductsAndPostsData() {
        loader.loadAndListenProductsAndPostsData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] (posts,products) in
                Logger.log("\(products)")
                self?.posts = posts
                self?.products = products
            }
            .store(in: &cancellables)
    }
}

extension String {
    
    var toBarCode: [String] {
        return self.split(separator: "/").compactMap{ String($0) }
    }
}
