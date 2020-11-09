//
//  MapViewController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 04/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{

    // Outlets and Actions
    @IBOutlet var modeSwitch : UISwitch!
    @IBOutlet var modeLabel : UILabel!
    
    @IBOutlet var mapView : MKMapView!
    var mapAnnotation = MKPointAnnotation()
    
    @IBOutlet var weatherView : UIView!
    
    var tapGestureRecognizer : UITapGestureRecognizer!
    @IBAction func placePinPress(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let point = sender.location(in: self.mapView)
            let latlon = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            print(latlon)
            
            mapAnnotation.coordinate = latlon
            
            self.mapView.addAnnotation(mapAnnotation)
        }
    }
    
    @IBAction func modeChange(sender : UISwitch) {
        if sender.isOn {
            renderPinMode()
        } else {
            renderTrackMode()
        }
    }
    
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        
        // False = Track, True = Pin
        modeSwitch.isOn = false
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation() //Get Initial location
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placePinPress))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        modeSwitch.addTarget(self, action: #selector(modeChange), for: UIControl.Event.valueChanged)
        modeChange(sender: modeSwitch); //Set default

    }
    
    // When the toggle is ON will display weather based on where the pin is
    func renderPinMode() {
        modeLabel.text = "Pin Mode"
        mapView.showsUserLocation = false;
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        locationManager?.requestLocation();
        mapAnnotation.coordinate = (locationManager?.location?.coordinate)!
        mapView.addAnnotation(mapAnnotation)
    }
    
    // When the toggle is OFF will show the regular view where the user location is shown and tracked
    func renderTrackMode() {
        modeLabel.text = "Follow Mode"
        
        // Handle changes to map view
        mapView.removeGestureRecognizer(tapGestureRecognizer)
        mapView.showsUserLocation = true;
        mapView.removeAnnotation(mapAnnotation)
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
        
        locationManager?.requestLocation()
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
