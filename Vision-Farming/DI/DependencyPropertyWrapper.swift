//
//  Dele.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation

@propertyWrapper
struct Inject<Inject> {
    
    var inject: Inject
    
    init(_ dependencyType: ServiceType = .newInstance) {
        guard let inject = ServiceContainer.resolve(dependencyType: dependencyType, Inject.self) else {
            fatalError("No dependency of type \(String(describing: Inject.self)) registered!")
        }
        self.inject = inject
    }
    
    var wrappedValue: Inject {
        get { self.inject }
        mutating set { inject = newValue }
    }
}
