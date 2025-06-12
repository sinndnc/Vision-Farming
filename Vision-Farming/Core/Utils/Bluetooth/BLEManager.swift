//
//  BLEManager.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/3/25.
//

import Foundation
import CoreBluetooth

enum BLEUUID {
    static let targetService = CBUUID(string: "FFF0")
    static let writeCharacteristic = CBUUID(string: "FFF1")
    static let readCharacteristic = CBUUID(string: "FFF2")
}

final class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var connectedPeripheral: CBPeripheral?
    @Published var receivedData: Data?

    private var centralManager: CBCentralManager!
    private var sensorCharacteristic: CBCharacteristic?
    public let targetServiceUUID = CBUUID(string: "ABCD1234")
    public let targetCharacteristicUUID = CBUUID(string: "12345678") 
    
    private var writeCharacteristic: CBCharacteristic?
    private var readCharacteristic: CBCharacteristic?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            Logger.log("Bluetooth açık, taramaya hazır.")
            central.scanForPeripherals(withServices: [targetServiceUUID], options: nil)
        default:
            Logger.log("Bluetooth durumu uygun değil: \(central.state.rawValue)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        Logger.log("Bulunan cihaz: \(peripheral.name ?? "Bilinmeyen")")
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func startScan() {
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: [BLEUUID.targetService], options: nil)
    }
    
    func write(data: Data) {
        guard let peripheral = connectedPeripheral, let char = writeCharacteristic else { return }
        peripheral.writeValue(data, for: char, type: .withResponse)
    }
    
    func connect(to peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Logger.log("Bağlandı: \(peripheral.name ?? "Bilinmeyen")")
        peripheral.discoverServices([targetServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([targetCharacteristicUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == targetCharacteristicUUID {
                sensorCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == targetCharacteristicUUID, let data = characteristic.value {
            NotificationCenter.default.post(name: Notification.Name("didReceiveSensorData") , object: nil)
        }
    }
}
