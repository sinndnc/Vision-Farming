//
//  NotificationView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/21/25.
//

import SwiftUI

struct NotificationView: View {
    
    @AppStorage("Notifications") private var showNotifications: Bool = false
    @StateObject private var viewModel = NotificationsViewModel()

    var body: some View {
        List{
            Toggle("Show Notifications", isOn: $viewModel.settings.showNotifications)
                .font(.headline)
                .fontWeight(.medium)
            
            Section {
                Toggle("Daily Reports", isOn: $viewModel.settings.reportsSettings.daily)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
                
                Toggle("Weekly Reports", isOn: $viewModel.settings.reportsSettings.weekly)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)

                Toggle("Monthly Reports", isOn: $viewModel.settings.reportsSettings.monthly)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
            } header: {
                Text("Reports")
            }
            
            Section {
                Toggle("Warnings and Alerts", isOn: $viewModel.settings.sensorsSettings.warningsAndAlerts)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)

                Toggle("Updates and Suggests", isOn: $viewModel.settings.sensorsSettings.updateAndSuggests)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
            } header: {
                Text("Sensors")
            }
            
            Section {
                Toggle("Daily Information", isOn: $viewModel.settings.weatherSettings.dailyInformation)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)

                Toggle("Warnings and Alerts", isOn: $viewModel.settings.weatherSettings.warningsAndAlerts)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)

                Toggle("Updates and Suggests", isOn: $viewModel.settings.weatherSettings.updatesAndSuggests)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
            } header: {
                Text("Weather")
            }
            
            Section {
                Toggle("Warnings and Alerts", isOn: $viewModel.settings.aiSettings.warningsAndAlerts)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
                
                Toggle("Informations and Suggests", isOn: $viewModel.settings.aiSettings.informationAndSuggests)
                    .font(.callout)
                    .fontWeight(.medium)
                    .disabled(!viewModel.settings.showNotifications)
            } header: {
                Text("AI-Suggested")
            }
            
        }
        .navigationTitle("Notifications")
    }
}

#Preview {
    NavigationStack{
        NotificationView()
    }
}
