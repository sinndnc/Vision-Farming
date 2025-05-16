//
//  ProductData.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/10/25.
//


import Foundation
import CoreLocation

struct BarcodeProduct: Codable {
    var id : String
    var barcode : String
    var name : String
    var description : String
    var brand : String
    var image : Data?
}
