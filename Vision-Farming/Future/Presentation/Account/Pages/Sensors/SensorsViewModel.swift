//
//  SensorsViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/24/25.
//


import Foundation

final class SensorsViewModel : ObservableObject {
    
    @Published var sensors: [Sensor] = []
    @Published var isEditing : Bool = false
    @Published var isSheetOpen : Bool = false

    init() {
        self.sensors = [
            Sensor(id: "1", name: "Sıcaklık Sensörü", type: .temperature, unit: "°C", value: 24.5, isActive: true, lastUpdated: Date()),
            Sensor(id: "2", name: "Nem Sensörü", type: .airMoisture, unit: "%", value: 65.2, isActive: true, lastUpdated: Date().addingTimeInterval(-300)),
            Sensor(id: "3", name: "Toprak pH Sensörü", type: .soilPh, unit: "", value: 6.8, isActive: false, lastUpdated: Date().addingTimeInterval(-600)),
            Sensor(id: "4", name: "Hava Kalitesi Sensörü", type: .airQuality, unit: "AQI", value: 45, isActive: true, lastUpdated: Date().addingTimeInterval(-900)),
            Sensor(id: "5", name: "Toprak Nemi Sensörü", type: .soilMoisture, unit: "%", value: 40.3, isActive: true, lastUpdated: Date().addingTimeInterval(-1200)),
            Sensor(id: "6", name: "Toprak pH Sensörü", type: .soilPh, unit: "", value: 6.8, isActive: true, lastUpdated: Date().addingTimeInterval(-600)),
            Sensor(id: "7", name: "Toprak pH Sensörü", type: .soilPh, unit: "", value: 6.6, isActive: true, lastUpdated: Date().addingTimeInterval(-600)),
            Sensor(id: "8", name: "Toprak pH Sensörü", type: .soilPh, unit: "", value: 7.2, isActive: true, lastUpdated: Date().addingTimeInterval(-600)),
        ]
    }
    
    func activeSensors(_ sensors : [Sensor]) -> Int {
        sensors.filter({$0.isActive == true}).count
    }
    
    var groupedSensors: [String: [Sensor]] {
        Dictionary(grouping: sensors, by: { $0.type.rawValue })
    }
    
    func removeItem(at offsets: IndexSet){
        sensors.remove(atOffsets: offsets)
    }
    
}
