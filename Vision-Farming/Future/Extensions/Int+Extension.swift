//
//  Int+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/25/25.
//

import Foundation


extension Int : @retroactive Identifiable {
    
    public var id: Self { self }
}
