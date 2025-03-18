//
//  ScanViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/15/25.
//

import AVFoundation
import Foundation
import SwiftUI
import os.log
import VisionKit

final class ScanViewModel : ObservableObject {
    
    @Published var recognizedItems: [RecognizedItem] = []
    
    
}

