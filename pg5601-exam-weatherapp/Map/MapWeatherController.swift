//
//  MapWeatherController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 06/11/2020.
//

import UIKit
import CoreLocation

protocol MapWeatherDelegate {
    func getWeatherOnLocation(coordinate : CLLocationCoordinate2D) -> Timesery
}

class MapWeatherController: UIViewController {
    
    //weak var delegate: MapWeatherDelegate?

    @IBOutlet var weatherIcon : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    func didGetWeather() {
        //delegate?.did
    }
}

