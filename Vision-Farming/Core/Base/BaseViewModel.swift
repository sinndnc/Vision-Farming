//
//  BaseViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/5/25.
//

import Foundation
import Combine

class BaseViewModel : ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
}
