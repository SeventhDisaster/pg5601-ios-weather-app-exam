//
//  MapWeatherController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 06/11/2020.
//

import UIKit
import CoreLocation

class MapWeatherController: UIViewController, MapWeatherDelegate {

    @IBOutlet var weatherIcon : UIImageView!
    @IBOutlet var latitude : UILabel!
    @IBOutlet var longitude : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapWeather.delegate = self
    }
    
    func didFetchWeatherData(_ weather: ForecastData?) {
        if weather == nil {
            self.latitude.text = "Failed to recieve"
            self.longitude.text = "Network Call Failed"
            self.weatherIcon.image = UIImage.init(named: "unknown")
            return
        }
        
        let coordinateArray = weather!.geometry.coordinates
        self.latitude.text = String(coordinateArray[0])
        self.longitude.text = String(coordinateArray[1])
        self.weatherIcon.image = UIImage(named: weather!.properties.timeseries[0].data.next1_Hours?.summary.symbolCode.rawValue ?? "unknown")
    }
}

