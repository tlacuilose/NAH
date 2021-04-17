//
//  PinNah.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 17/04/21.
//

import MapKit
import CoreLocation


struct PinNah {
    let title: String
    let lat: Double
    let long: Double
    
    init(_ title: String, _ lat: Double, _ long: Double) {
        self.title = title
        self.lat = lat
        self.long = long
    }
    
    func getPin() -> MKPointAnnotation {
        let coor = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        let pin = MKPointAnnotation()
        pin.coordinate = coor
        pin.title = self.title
        return pin
    }
}
