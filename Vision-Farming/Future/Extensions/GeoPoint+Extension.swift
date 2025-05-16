//
//  GeoPoint+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/12/25.
//

import FirebaseFirestore
import CoreLocation

extension GeoPoint{
    
    var toCLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

extension [GeoPoint]{
    
    func toCLLocationCoordinate2D() -> [CLLocationCoordinate2D] {
        self.map { geoPoint in
            return CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        }
    }
}
