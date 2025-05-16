//
//  GeoPointTransformer.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/12/25.
//

import FirebaseFirestore
import CoreLocation
import CoreData

@objc(GeoPointTransformer)
class GeoPointTransformer: ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let geoPoints = value as? [GeoPoint] else { return nil }
        
        let geoDictArray = geoPoints.map { ["latitude": $0.latitude, "longitude": $0.longitude] }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: geoDictArray, options: .fragmentsAllowed)
            return data
        } catch {
            print("GeoPoint array archiving failed: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            if let geoDictArray = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String: Double]] {
                return geoDictArray.compactMap {
                    if let lat = $0["latitude"], let lon = $0["longitude"] {
                        return GeoPoint(latitude: lat, longitude: lon)
                    }
                    return nil
                }
            }
        } catch {
            print("GeoPoint array unarchiving failed: \(error)")
        }
        return nil
    }
}
