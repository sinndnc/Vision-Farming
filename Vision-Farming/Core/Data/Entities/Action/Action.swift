//
//  Action.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import Foundation

struct Action : Codable,Hashable{
    var date : Date
    var type : String
    var note : String
}
