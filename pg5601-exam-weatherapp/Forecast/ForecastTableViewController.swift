//
//  ForecastTableViewController.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 26/10/2020.
//

import UIKit
import CoreData

class ForecastTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Exam Note:
    // I made an assumption here based on the exam's task, that ONLY THE FIRST INDEX given in the returned timeseries array
    // was meant to be used to display the "forecast", given that was the only reasonable place to have the layout
    // match that which was shown in the given example image.
    // The rest of the times are contained within the timesery array

    // Base URL includes the given coordinates for the exam
    var baseURL : String = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.911166&lon=10.744810"
    var meta : Meta? = nil;
    var forecasts : [Timesery] = []
    
    @IBOutlet var table : UITableView!
    
    @IBOutlet var location : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Forecasts"
        location.text = "Høyskolen Kristiania: Campus Kvadraturen"
        
        if userLocation != nil {
            baseURL = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(userLocation!.lat)&lon=\(userLocation!.lon)"
            location.text = "Din Lokasjon (\(userLocation!.lat) \(userLocation!.lon)"
        }

        table.delegate = self;
        table.dataSource = self;
        
        fetchGeneralWeatherData(url: baseURL)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userLocation != nil {
            baseURL = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(userLocation!.lat)&lon=\(userLocation!.lon)"
            location.text = "Din Lokasjon (\(userLocation!.lat), \(userLocation!.lon))"
        }
        fetchGeneralWeatherData(url: baseURL)
    }

    // MARK: - Table view data source
    
    // API Call
    func fetchGeneralWeatherData(url : String) -> Void {
        let urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedForecast = try decoder.decode(ForecastData.self, from: data!)
                self.meta = decodedForecast.properties.meta //Set Meta Info
                self.forecasts = decodedForecast.properties.timeseries //Set Forecast List
                
                
                // Reload the table data in the main thread
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } catch {
                print("error: ", error)
            }
        }
        
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Make sure to edit the return value here when adding new data to the tableview
        
        return 4;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell;
        
        if forecasts.count > 0 {
            let forecast = forecasts[0];
            
            switch indexPath.row {
            case 0: // Now
                cell.title.text = "Now"
                cell.descriptor.text = "Temperature"
                cell.possibleValue.text = "\(forecast.data.instant.details.airTemperature)º \(meta?.units.airTemperature ?? "")"
                cell.unitValue.isHidden = true
            case 1: // Next 1 Hour
                cell.title.text = "Next 1 Hour"
                cell.descriptor.text = "Weather"
                let symbolCode = forecast.data.next1_Hours?.summary.symbolCode
                cell.possibleValue.text = symbolCodeToWeather(symbolCode: symbolCode!)
                cell.unitValue.text = "\(forecast.data.next1_Hours?.details.precipitationAmount ?? 0) \(meta?.units.precipitationAmount ?? "")"
            case 2: // Next 6 Hours
                cell.title.text = "Next 6 Hours"
                cell.descriptor.text = "Weather"
                let symbolCode = forecast.data.next1_Hours?.summary.symbolCode
                cell.possibleValue.text = symbolCodeToWeather(symbolCode: symbolCode!)
                cell.unitValue.text = "\(forecast.data.next1_Hours?.details.precipitationAmount ?? 0) \(meta?.units.precipitationAmount ?? "")"
            case 3: // Next 12 Hours
                cell.title.text = "Next 12 Hours"
                cell.descriptor.text = "Weather"
                let symbolCode = forecast.data.next1_Hours?.summary.symbolCode
                cell.possibleValue.text = symbolCodeToWeather(symbolCode: symbolCode!)
                cell.unitValue.isHidden = true
                
            default:
                cell.title.text = "Error"
            }
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
