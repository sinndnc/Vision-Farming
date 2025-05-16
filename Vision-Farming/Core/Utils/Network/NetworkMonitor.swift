//
//  NetworkMonitor.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//

import Network
import Combine

final class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    @Published private(set) var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
