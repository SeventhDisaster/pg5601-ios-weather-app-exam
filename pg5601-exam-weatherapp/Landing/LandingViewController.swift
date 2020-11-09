//
//  LandingViewController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 08/11/2020.
//

import UIKit
import CoreLocation

// The API is called and refreshed whenever the get location is called (Which is attempted whenever the view appears)

class LandingViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var day : UILabel!
    @IBOutlet var umbrella : UILabel!
    @IBOutlet var updateTime : UILabel!
    @IBOutlet var weatherIcon : UIImageView!
    var weatherIconTimesClicked = 0
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    @IBAction func performAnimation(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if weatherIconTimesClicked < 1 {
                UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseIn], animations: {
                    self.weatherIcon.transform = .init(rotationAngle: .pi)
                }, completion: { _ in
                    //Becuase the first animation only completes half the animation, the second half must be run here
                    UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseOut], animations: {
                        self.weatherIcon.transform = .init(rotationAngle: .pi * 2)
                    }, completion: nil)
                    self.weatherIcon.transform = CGAffineTransform(rotationAngle: 0) //Reset to original
                    self.weatherIconTimesClicked += 1
                })
            } else {
                UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .curveEaseInOut], animations: {
                    self.weatherIcon.transform = CGAffineTransform(scaleX: 3, y: 3)
                }, completion: {_ in
                    self.weatherIcon.transform = CGAffineTransform(scaleX: 1, y: 1) //Reset to original
                    self.weatherIconTimesClicked = 0
                })
            }
        }
    }
    
    var locationManager: CLLocationManager?
    
    var lat: Double?
    var lon: Double?
    
    //Index below represents which date is displayed
    var weekList : [SimpleWeatherData] = []
    var currentlyDisplayingIndex = 0

    @IBOutlet var swipeView : UIView!
    var swipeForwardGestureRecognizer : UISwipeGestureRecognizer!
    @IBAction func nextDay (sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            let nextIndex = currentlyDisplayingIndex + 1
            print("Swipe to next index at: \(nextIndex)")
            guard weekList.count != nextIndex && weekList.count >= nextIndex else {
                print("Index: \(nextIndex) was out of bounds. No action taken")
                return //Prevent overstepping bounds
            }
            currentlyDisplayingIndex += 1
            renderDay(onIndex: currentlyDisplayingIndex)
        }
    }
    var swipeBackwardGestureRecognizer : UISwipeGestureRecognizer!
    @IBAction func prevDay (sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            let prevIndex = currentlyDisplayingIndex - 1
            print("Swipe to previous index at: \(prevIndex)")
            guard prevIndex >= 0 else {
                print("Index: \(prevIndex) was out of bounds. No action taken")
                return //Prevent understepping bounds
            }
            currentlyDisplayingIndex -= 1
            renderDay(onIndex: currentlyDisplayingIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        weatherIcon.image = UIImage.init(named: "unknown")
        
        //First ask and get the user's location (Lat long is needed to call the URL properly)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        if(locationManager?.location == nil){
            locationManager?.requestLocation() //Get Initial location -> Call the API when user provides a location
        }
        
        swipeForwardGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextDay))
        swipeForwardGestureRecognizer.numberOfTouchesRequired = 1
        swipeForwardGestureRecognizer.direction = .left
        swipeBackwardGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(prevDay))
        swipeBackwardGestureRecognizer.numberOfTouchesRequired = 1
        swipeBackwardGestureRecognizer.direction = .right //Kind of redundant but present for readability (right is default)
        swipeView.addGestureRecognizer(swipeForwardGestureRecognizer)
        swipeView.addGestureRecognizer(swipeBackwardGestureRecognizer)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performAnimation))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        renderDay(onIndex: currentlyDisplayingIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager?.requestLocation() //Try to refresh the data whenever the view re-appears
    }
    
    func renderDay(onIndex: Int) {
        if weekList.count < 1 {
            day.text = "No data"
            weatherIcon.image = UIImage.init(named: "unknown")
            return
        }
        
        let selected = weekList[onIndex]
        
        day.text = weekList[onIndex].day
        updateTime.text = "Last updated: \(selected.updateTime ?? "Error")"
        
        weatherIcon.image = UIImage.init(named: selected.nextHours.summary.symbolCode.rawValue)
        weatherIcon.addGestureRecognizer(tapGestureRecognizer)
        
        if weekList[onIndex].nextHours.details.precipitationAmount > 0 {
            umbrella.text = "Precipitation expected, get an umbrella"
        } else {
            umbrella.text = "No umbrella needed, have a nice day"
        }
    }
    
    // API Call
    func fetchWeather(url : String) -> Void {
        let urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedForecast = try decoder.decode(ForecastData.self, from: data!)
                
                // Set store the data the views after the API has been called
                DispatchQueue.main.async {
                    
                    //Set the datasource (orderedViews) with the required data to generate the views
                    for entry in parseForecastToSimpleWeekData(data: decodedForecast.properties) {
                        self.weekList.append(entry)
                    }
                    
                    self.renderDay(onIndex: self.currentlyDisplayingIndex)
                }
            } catch {
                print("error: ", error)
                DispatchQueue.main.async {
                    self.day.text = "API Call failed"
                }
            }
        }
        
        task.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = Double(String(format: "%.4f", locations[0].coordinate.latitude))!
        lon = Double(String(format: "%.4f", locations[0].coordinate.longitude))!
        let url = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(lat!)&lon=\(lon!)"
        fetchWeather(url: url)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
