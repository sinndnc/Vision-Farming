//
//  Vegetables.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/20/25.
//

import Foundation

struct Category : Codable,Identifiable {
    var id : String
    var category_name: String
    var category_description: String
}

struct SubCategory : Codable,Identifiable {
    var id : String
    var name: String
    var description: String
}
