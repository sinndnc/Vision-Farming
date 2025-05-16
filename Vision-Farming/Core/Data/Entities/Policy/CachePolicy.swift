//
//  CachePolicy.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/6/25.
//


enum CachePolicy {
    case networkOnly
    case localOnly
    case staleWhileRevalidate(ttlSeconds: Int = 3600)
}
