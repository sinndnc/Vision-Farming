//
//  ScanViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/15/25.
//

import Foundation
import SwiftUI
import Combine
import VisionKit

final class ScanViewModel : ObservableObject {
    
    @Published var recognizedItems: [RecognizedItem] = []
    
    
    @Published var productData: BarcodeProduct?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProductData(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Geçersiz URL"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BarcodeProduct.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Hata: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] decodedData in
                self?.productData = decodedData
            })
            .store(in: &cancellables)
    }
    
}
