//
//  Product.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/11/25.
//

import FirebaseFirestore
import Foundation

struct MarketProduct: FirestoreEntity {
    @DocumentID var id: String?
    var name: String
    var description: String
    var category: ProductEnum
    var image : Data?
    
    var stock: Int
    var price: Double
    var currency: String
    var isAvailable: Bool
    var unit: String
    
    var farm_id: String
    var region : String
    
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
}
