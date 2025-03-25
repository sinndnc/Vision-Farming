//
//  WeatherNotificationsSettings.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/23/25.
//

import Foundation

struct WeatherNotificationsSettings : Codable {
    var dailyInformation : Bool
    var warningsAndAlerts : Bool
    var updatesAndSuggests : Bool
}
