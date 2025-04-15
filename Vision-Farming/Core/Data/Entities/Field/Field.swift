//
//  Field.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/11/25.
//

import Foundation
import FirebaseFirestore
import CoreLocation


struct Field : FirestoreEntity {
    @DocumentID var id : String?
    var name : String
    var owner_farm : String
    var coordinates : [GeoPoint]
    var harvest_date : Date
    var planted_date : Date
}


extension [GeoPoint]{
    
    func toCLLocationCoordinate2D() -> [CLLocationCoordinate2D] {
        var geoPoints : [CLLocationCoordinate2D] = []
        for geoPoint in self{
            geoPoints.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(geoPoint.latitude), longitude: CLLocationDegrees(geoPoint.longitude)))
        }
        return geoPoints
    }
}
