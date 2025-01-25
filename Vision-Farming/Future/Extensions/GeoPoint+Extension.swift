//
//  GeoPoint+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/24/25.
//

import Foundation
import Firebase
import CoreLocation

extension [GeoPoint]{
    
    var toCLLocationCoordinate2D : [CLLocationCoordinate2D] {
        var coordinates : [CLLocationCoordinate2D] = []
        self.forEach { geoPoint in
            coordinates.append(CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude))
        }
        return coordinates
    }
    
    
    func getCenterOfField() -> CLLocationCoordinate2D {
        func degreesToRadians(_ degrees: Double) -> Double {
            return degrees * .pi / 180
        }
        
        func radiansToDegrees(_ radians: Double) -> Double {
            return radians * 180 / .pi
        }
        
        var xTotal = 0.0
        var yTotal = 0.0
        var zTotal = 0.0
        
        for coordinate in self {
            let latRad = degreesToRadians(coordinate.latitude)
            let lonRad = degreesToRadians(coordinate.longitude)
            
            xTotal += cos(latRad) * cos(lonRad)
            yTotal += cos(latRad) * sin(lonRad)
            zTotal += sin(latRad)
        }
        
        // Ortalama x, y, z değerlerini hesapla
        let count = Double(self.count)
        let xMean = xTotal / count
        let yMean = yTotal / count
        let zMean = zTotal / count
        
        // Merkezi tekrar enlem ve boylam değerine dönüştür
        let centralLongitude = atan2(yMean, xMean)
        let centralSquareRoot = sqrt(xMean * xMean + yMean * yMean)
        let centralLatitude = atan2(zMean, centralSquareRoot)
        
        // Sonuçları dereceye dönüştür
        let centralLatitudeDegrees = radiansToDegrees(centralLatitude)
        let centralLongitudeDegrees = radiansToDegrees(centralLongitude)
        
        return CLLocationCoordinate2D(latitude: centralLatitudeDegrees, longitude: centralLongitudeDegrees)
    }
    
}

