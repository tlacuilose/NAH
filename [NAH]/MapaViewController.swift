//
//  MapaViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 06/04/21.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!

    private let locationManager = CLLocationManager()
    
    private static let MAX_REGION_METERS = CLLocationDistance(100000)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()

        let pines: [PinNah] = [PinNah("San Juán Tezontla", 19.544770, -98.815421), PinNah("Alcohuacan", 19.321416, -98.844517), PinNah("Tetelcingo", 18.869534, -98.931438), PinNah("Chiconcuac", 19.557352, -98.899887), PinNah("Pueblo de Milpa Alta", 19.211319, -98.982901), PinNah("Cuautla", 18.838790, -98.949608), PinNah("San Jerónimo", 19.517891, -98.762461), PinNah("Cuscatlán", 13.704121, -89.231364), PinNah("Santa Catarina", 18.972187, -99.145260), PinNah("San Pablo Ixacoyoc", 19.470638, -98.796959), PinNah("Escuintla", 14.298574, -90.782015), PinNah("Tepoztlán", 18.996569, -99.096158), PinNah("Huesca de Ocampa", 20.202251, -98.575344), PinNah("Hueyapan", 18.885226, -98.692152), PinNah("Cueytepec", 18.862699, -99.324663), PinNah("Tlaxcala Apizaco", 19.411767, -98.145540), PinNah("Tetela", 18.896714, -98.728217), PinNah("Puente de Ixtla", 18.614465, -99.327043), PinNah("Chalco", 19.263090, -98.898412), PinNah("Amecameca", 19.119521, -98.763713), PinNah("Temixco", 18.842600, -99.237031), PinNah("Xococotla", 18.685589, -99.253316), PinNah("Chicontepec", 20.973458, -98.166029), PinNah("Ixhuatlán", 20.688095, -98.014368), PinNah("Benito Juárez", 20.884605, -98.206448), PinNah("Sierra Mazateca", 18.272410, -96.768035)]

        pines.forEach { (pin) in
            mapView.addAnnotation(pin.getPin())
        }

        let blankLocation = CLLocationCoordinate2D()
        let blankRegion = MKCoordinateRegion(center: blankLocation, latitudinalMeters: Self.MAX_REGION_METERS, longitudinalMeters: Self.MAX_REGION_METERS)
        mapView.setRegion(blankRegion, animated: false)
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.isZoomEnabled = true
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.stopUpdatingLocation()
            self.mapView.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: Self.MAX_REGION_METERS, longitudinalMeters: Self.MAX_REGION_METERS)
                self.mapView.setRegion(region, animated: true)
            }
    }
    
}
