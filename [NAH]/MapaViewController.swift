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

        let classic = CLLocationCoordinate2DMake( 19.43460159632058, -99.13308240260533)
        let veracruz = CLLocationCoordinate2DMake( 19.189454009510374, -96.16361537521452)
        let puebla = CLLocationCoordinate2DMake( 19.058816658573384, -98.21906639439207)
        let guerrero = CLLocationCoordinate2DMake( 17.71486919956484, -99.65900019823195)
        let snluis = CLLocationCoordinate2DMake( 22.13937517941049, -100.97873737798817)

        let pinclass = MKPointAnnotation()
        let pinver = MKPointAnnotation()
        let pinpue = MKPointAnnotation()
        let pingue = MKPointAnnotation()
        let pinsn = MKPointAnnotation()

        pinclass.coordinate = classic
        pinclass.title = "Nahuatl Clasico"

        pinver.coordinate = veracruz
        pinver.title = "Nahuatl de Veracruz"

        pinpue.coordinate = puebla
        pinpue.title = "Nahuatl de Puebla"

        pingue.coordinate = guerrero
        pingue.title = "Nahuatl de Guerrero"

        pinsn.coordinate = snluis
        pinsn.title = "Nahuatl de San Luis"


        mapView.region = MKCoordinateRegion(center: classic, latitudinalMeters: 10000, longitudinalMeters: 10000)

        mapView.addAnnotation(pinclass);
        mapView.addAnnotation(pingue);
        mapView.addAnnotation(pinver);
        mapView.addAnnotation(pinpue);
        mapView.addAnnotation(pinsn);
    }
}
