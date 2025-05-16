//
//  SectionItem.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/3/25.
//

import Foundation


struct SectionItem : Identifiable {
    var id = UUID()
    var icon : String
    var title : String
    let type: SectionEnum
    var detail : String? = nil
}
