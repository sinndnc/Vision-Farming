    //
//  TabViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/18/25.
//

import Combine
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore

enum TabEnum : String {
    case dashboard
    case community
    case adding
    case marketPlace
    case budget
}

class RootViewModel: ObservableObject{
    
    @Published public var user : User?
    @Published public var farms: [Farm] = []
    @Published public var crops : [Crop] = []
    @Published public var posts : [Post] = []
    @Published public var fields: [Field] = []
    @Published public var sensors: [Sensor] = []
    @Published public var products: [MarketProduct] = []
    @Published public var transactions : [Transaction] = []
    
    @Published public var error: NetworkErrorCallback?
    @Published public var sections : [SectionItem] = []
    @Published public var selectedTab : TabEnum = .adding
    
    let loader: DataLoader
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
                    Logger.log("\(error)")
                }
            } receiveValue: { [weak self] user, transactions, crops, farms, fields ,sensors in
                self?.user = user
                self?.crops = crops
                self?.farms = farms
                self?.fields = fields
                self?.sensors = sensors
                self?.transactions = transactions
            }
            .store(in: &cancellables)
    }
    
    private func loadAndListenProductsAndPostsData() {
        loader.loadAndListenProductsAndPostsData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                    Logger.log("\(error)")
                }
            } receiveValue: { [weak self] (posts,products) in
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
