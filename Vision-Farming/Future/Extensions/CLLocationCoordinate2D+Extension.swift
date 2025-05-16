//
//  CLLocationCoordinate2D+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/12/25.
//

import FirebaseFirestore
import CoreLocation


extension CLLocationCoordinate2D{
    
    func toGeoPoint() -> GeoPoint {
        return GeoPoint(latitude: self.latitude, longitude: self.longitude)
    }
}

extension [CLLocationCoordinate2D]{
    
    func toGeoPoint() -> [GeoPoint] {
        self.map { coordinate in
            return GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
