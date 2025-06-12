//
//  Comparable+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/17/25.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
