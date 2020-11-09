//
//  LandingViewController.swift
//  pg5601-exam-weatherapp
//
//  Created by Candidate 10061 on 08/11/2020.
//

import UIKit
import CoreLocation
import CoreData

// The API is called and refreshed whenever the get location is called (Which is attempted whenever the view appears)

class LandingViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var errorLabel : UILabel!
    @IBOutlet var day : UILabel!
    @IBOutlet var umbrella : UILabel!
    @IBOutlet var updateTime : UILabel!
    @IBOutlet var weatherIcon : UIImageView!
    var weatherIconTimesClicked = 0
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    //Used to show and hide the raindrops for rainy days
    var rainDropA : UIImageView!
    var rainDropB : UIImageView!
    var rainDropC : UIImageView!
    
    func makeRainDrop() -> UIImageView {
        let imgName = "raindrop"
        let img = UIImage(named: imgName)
        let view = UIImageView(image: img)
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }
    
    @IBAction func performAnimation(sender: UITapGestureRecognizer) {
        print("Tapped")
        if sender.state == .ended {
            
            //Because the rotation mechanism is too smart to perform an easy full 360 rotation, this animation chain handles that.
            //The animation will always try to reach its intended destination using the shortest route possible
            //for this reason I can only perform a 180 degree rotation at most at a time, otherwise it will simply go the other way.
            if weatherIconTimesClicked < 1 {
                UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseIn], animations: {
                    self.weatherIcon.transform = .init(rotationAngle: .pi)
                }, completion: { _ in
                    //Becuase the first animation only completes half the animation, the second half must be run here
                    UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseOut], animations: {
                        self.weatherIcon.transform = .init(rotationAngle: .pi * 2)
                    }, completion:{ _ in
                        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseIn], animations: {
                            self.weatherIcon.transform = .init(rotationAngle: -.pi)
                        }, completion:{ _ in
                            UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseOut], animations: {
                                self.weatherIcon.transform = .init(rotationAngle: -(.pi * 2) + 0.001) //Needs to be very specific to not be wonky
                            }, completion:{ _ in
                                self.weatherIcon.transform = CGAffineTransform(rotationAngle: 0) //Reset to original
                                self.weatherIconTimesClicked += 1
                            })
                        })
                    })
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
        
        rainDropA = makeRainDrop()
        rainDropB = makeRainDrop()
        rainDropC = makeRainDrop()
        
        renderDay(onIndex: currentlyDisplayingIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager?.requestLocation() //Try to refresh the data whenever the view re-appears
    }
    
    
    // This method renders the day and also holds the conditional unique animations for certain weather types
    func renderDay(onIndex: Int) {
        if weekList.count < 1 {
            day.text = "No data"
            weatherIcon.image = UIImage.init(named: "unknown")
            return
        }
        
        errorLabel.text = "" // Don't show any error text by default
        
        let selected = weekList[onIndex]
        
        day.text = weekList[onIndex].day
        updateTime.text = "Last updated: \(selected.updateTime ?? "Error")"
        
        weatherIcon.image = UIImage.init(named: selected.nextHours.summary.symbolCode.rawValue)
        weatherIcon.addGestureRecognizer(tapGestureRecognizer)
        
        //Condition: Clearsky + Daytime
        if weekList[onIndex].nextHours.summary.symbolCode == SymbolCode.clearskyDay {
            print("Clearsky day detected: Starting animation")
            UIView.animateKeyframes(withDuration: 3, delay: 0, options: [.repeat, .allowUserInteraction], animations: {
                self.weatherIcon.transform = .init(rotationAngle: .pi)
            }, completion: {
                _ in
                    //Becuase the first animation only completes half the animation, the second half must be run here
                UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: {
                        self.weatherIcon.transform = .init(rotationAngle: .pi * 2)
                    }, completion: nil)
                    self.weatherIcon.transform = CGAffineTransform(rotationAngle: 0) //Reset to original
                    self.weatherIconTimesClicked += 1
            })
            UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.calculationModeLinear, .allowUserInteraction], animations: {
                self.view.backgroundColor =  UIColor.init(red: 1, green: 1, blue: 0.8, alpha: 1)
            }, completion: nil)
        } else {
            UIView.animateKeyframes(withDuration: 0, delay: 0, options: [.calculationModeLinear, .allowUserInteraction], animations: {
                self.weatherIcon.transform = .init(rotationAngle: 0)
                self.view.backgroundColor = .white
            }, completion: nil)
        }
        
        
        //Any precipitation causes the rain animation to appear (Any rain)
        if weekList[onIndex].nextHours.details.precipitationAmount > 0 {
            self.view.addSubview(rainDropA)
            rainDropA.transform = .init(translationX: 70, y: 0)
            self.view.addSubview(rainDropB)
            rainDropB.transform = .init(translationX: 150, y: 0)
            self.view.addSubview(rainDropC)
            rainDropC.transform = .init(translationX: 300, y: 0)
            
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.7, options: [.repeat, .allowUserInteraction], animations: {
                self.rainDropA.transform = .init(translationX: 70, y: 1000)
            }, completion: nil)
            UIView.animateKeyframes(withDuration: 1.5, delay: 1.1, options: [.repeat, .allowUserInteraction], animations: {
                self.rainDropB.transform = .init(translationX: 150, y: 1000)
            }, completion: nil)
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.6, options: [.repeat, .allowUserInteraction], animations: {
                self.rainDropC.transform = .init(translationX: 300, y: 1000)
            }, completion: nil)
        } else {
            //Remove raindrops on non rainy days
            self.rainDropA.removeFromSuperview()
            self.rainDropB.removeFromSuperview()
            self.rainDropC.removeFromSuperview()
        }
        
        
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
            let decoder = JSONDecoder()
            let defaults = UserDefaults.standard
            do {
                decoder.dateDecodingStrategy = .iso8601
                let decodedForecast = try decoder.decode(ForecastData.self, from: data!)
                
                // Set store the data the views after the API has been called
                DispatchQueue.main.async {
                    let entries = parseForecastToSimpleWeekData(data: decodedForecast.properties)
                    
                    //Set user default data (Save to disk) whenever the API has been called and data is reduced to what is useful
                    let encoder = JSONEncoder()
                    do {
                        defaults.removeObject(forKey: "storedWeek") //Clear out old data
                        try defaults.setValue(encoder.encode(entries), forKey: "storedWeek") //Insert new data
                    } catch {
                        print(error.localizedDescription)
                    }

                    //Set the datasource (orderedViews) with the required data to generate the views
                    print("Entries to load: \(entries.count)")
                    self.weekList.removeAll() //Clear out the array of any potential old data
                    for entry in entries {
                        self.weekList.append(entry)
                    }
                    
                    self.renderDay(onIndex: self.currentlyDisplayingIndex)
                }
            } catch {
                print("Error: ", error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorLabel.text = "API Call failed, Displaying Old Data"
                    let oldEntriesData = defaults.value(forKey: "storedWeek")
                    do {
                        let entries = try decoder.decode([SimpleWeatherData].self, from: oldEntriesData as! Data)
                        for entry in entries {
                            self.weekList.append(entry)
                        }
                        
                        self.renderDay(onIndex: self.currentlyDisplayingIndex)
                    } catch{
                        print(error.localizedDescription)
                        self.errorLabel.text = "API call failed, No saved data to display"
                    }
                }
            }
        }
        
        task.resume()
    }
    
    // Method reacts to location updates and will attempt to fetch the API whenever loaded
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = Double(String(format: "%.4f", locations[0].coordinate.latitude))!
        lon = Double(String(format: "%.4f", locations[0].coordinate.longitude))!
        let url = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(lat!)&lon=\(lon!)"
        fetchWeather(url: url) //Try to call the API and see if there is new data
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
