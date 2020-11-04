//
//  MapViewController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 04/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView : MKMapView!
    var mapAnnotation = MKPointAnnotation()
    
    @IBAction func placePinPress(sender: UILongPressGestureRecognizer) {
        sender.minimumPressDuration = 0.5 //Hold for at least .7 s
        if sender.state == .began {
            let point = sender.location(in: self.mapView)
            let latlon = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            print(latlon)
            
            mapAnnotation.coordinate = latlon
            
            self.mapView.addAnnotation(mapAnnotation)
        }
    }
    
    var locationManager: CLLocationManager?
    

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        locationManager?.requestLocation()
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        let holdGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(placePinPress))
        mapView.addGestureRecognizer(holdGestureRecognizer)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = (
            lat: Double(String(format: "%.4f", locations[0].coordinate.latitude))!,
            lon: Double(String(format: "%.4f", locations[0].coordinate.longitude))!
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
