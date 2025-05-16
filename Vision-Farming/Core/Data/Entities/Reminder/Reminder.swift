//
//  Reminder.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import Foundation

struct Reminder : Codable , Hashable {
    var uid : String = UUID().uuidString
    var title : String = ""
    var notes : String = ""
    var tags : [String] = []
    var start_date : Date = .now
    var finish_date : Date = .now
    var `repeat` : String = "Never"
    var early_reminder : String = "None"
    var isCompleted: Bool = false
}
