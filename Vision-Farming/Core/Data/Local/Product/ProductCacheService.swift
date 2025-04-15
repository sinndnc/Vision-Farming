//
//  ProductCacheService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import CoreData
import Foundation

class ProductCacheService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadCachedProducts() -> [MarketProduct] {
//        let request: NSFetchRequest<CachedProduct> = CachedProduct.fetchRequest()
//        guard let cached = try? context.fetch(request) else { return [] }
        return []
    }

    func cacheProducts(_ products: [MarketProduct]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedProduct.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? context.execute(deleteRequest)
        
        for product in products {
            let cached = CachedProduct(context: context)
            cached.id = product.id
            cached.name = product.name
            cached.productDescription = product.description
            cached.price = product.price
        }
        try? context.save()
    }
}
