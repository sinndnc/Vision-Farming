//
//  CropErrorCallback.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/3/25.
//

import Foundation


enum NetworkErrorCallback: Error {
    case local(Error)
    case remote(Error)
    case noData
    case noConnection
}
