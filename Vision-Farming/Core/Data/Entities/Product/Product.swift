//
//  Product.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import Foundation
import FirebaseFirestore
import CoreLocation

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var category: String
    var price: Double
    var currency: String
    var stock: Int
    var unit: String
    
    var images: [String]?
    var thumbnail: String?
    var rating: Double
    var reviewsCount: Int
    var isAvailable: Bool
    
    @ServerTimestamp var createdAt: Timestamp? 
    @ServerTimestamp var updatedAt: Timestamp?
    
    var tags: [String]
    var producerId: String
    
    var location: GeoPoint?
}
