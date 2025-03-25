//
//  NotificationsViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/23/25.
//

import Foundation
import Combine

struct NotificationsSettings: Codable {
    var showNotifications : Bool
    var aiSettings : AINotificationsSettings
    var reportsSettings: ReportsNotificationsSettings
    var sensorsSettings: SensorsNotificationsSettings
    var weatherSettings: WeatherNotificationsSettings
}

class NotificationsViewModel: ObservableObject {
    
    @Published var settings: NotificationsSettings{
        didSet {
            saveSettings()
        }
    }
    
    private let storageKey = "notificationSettings"
    private var cancellables = Set<AnyCancellable>()

    init() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(NotificationsSettings.self, from: savedData) {
            self.settings = decoded
        } else {
            self.settings = NotificationsSettings(
                showNotifications: true,
                aiSettings: AINotificationsSettings(warningsAndAlerts: true, informationAndSuggests: true),
                reportsSettings: ReportsNotificationsSettings(daily: true, weekly: true, monthly: true),
                sensorsSettings: SensorsNotificationsSettings(warningsAndAlerts: true, updateAndSuggests: true),
                weatherSettings: WeatherNotificationsSettings(dailyInformation: true,warningsAndAlerts: true, updatesAndSuggests: true)
            )
        }
        observeSettingsChanges()
        
    }
    
    
    private func observeSettingsChanges() {
        $settings
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveSettings()
            }
            .store(in: &cancellables)
    }
    
    private func saveSettings() {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
}
