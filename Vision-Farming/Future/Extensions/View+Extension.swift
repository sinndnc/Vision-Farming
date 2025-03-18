//
//  View+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/16/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func bottomMaskForSheet(mask : Bool = true ,_ height : CGFloat = 49) -> some View {
        self
            .background(RootSheetViewFinder(mask: mask ,height: height))
    }
}
