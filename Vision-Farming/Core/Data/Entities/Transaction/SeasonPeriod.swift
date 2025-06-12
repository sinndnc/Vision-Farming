//
//  SeasonPeriod.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Foundation

struct SeasonPeriod: Codable, Identifiable {
    var id: UUID { UUID() }
    var season: Season
    var year: Int
}
