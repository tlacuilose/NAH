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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationPoint = CLLocationCoordinate2DMake(19.284056, -99.136279)
        let pin = MKPointAnnotation()
        pin.coordinate = locationPoint
        pin.title = "Tu ubicacion"
        pin.subtitle = "Subtitulo"
        
        mapView.region = MKCoordinateRegion(center: locationPoint, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.addAnnotation(pin)
    }
}
