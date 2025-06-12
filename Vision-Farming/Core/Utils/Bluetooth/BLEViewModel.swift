//
//  BLEViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/11/25.
//

import Foundation
import CoreBluetooth
import Combine


final class BLEViewModel: ObservableObject {
    @Published var devices: [CBPeripheral] = []
    @Published var connectedDeviceName: String?
    @Published var receivedString: String?

    private var cancellables = Set<AnyCancellable>()
    private let bleManager = BLEManager()

    init() {
        bleManager.$discoveredPeripherals
            .assign(to: \.devices, on: self)
            .store(in: &cancellables)

        bleManager.$connectedPeripheral
            .compactMap { $0?.name }
            .assign(to: \.connectedDeviceName, on: self)
            .store(in: &cancellables)

        bleManager.$receivedData
            .compactMap { $0 }
            .map { String(decoding: $0, as: UTF8.self) }
            .assign(to: \.receivedString, on: self)
            .store(in: &cancellables)
    }

    func connect(to peripheral: CBPeripheral) {
        bleManager.connect(to: peripheral)
    }

    func send(_ text: String) {
        bleManager.write(data: Data(text.utf8))
    }
}
