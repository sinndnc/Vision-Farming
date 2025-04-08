//
//  CachedProduct.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import CoreData
import Foundation

 @objc(CachedProduct)
 public class CachedProduct: NSManagedObject {
     @NSManaged public var id: String?
     @NSManaged public var name: String?
     @NSManaged public var productDescription: String?
     @NSManaged public var price: Double
 }

