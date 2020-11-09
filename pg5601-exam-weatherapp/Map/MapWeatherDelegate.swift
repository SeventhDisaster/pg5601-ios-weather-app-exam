//
//  MapWeatherDelegate.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 09/11/2020.
//

import Foundation

protocol MapWeatherDelegate: AnyObject {
    func didFetchWeatherData(_ weather : ForecastData?)
}

public class MapWeather {
    
    weak var delegate: MapWeatherDelegate?
    
    //This uses the same call method as anywhere else.
    func fetchWeatherAt(lat: Double, lon: Double) {
        let url = "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=\(lat)&lon=\(lon)"
        let urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                var decodedForecast : ForecastData?
                if data != nil {
                    decodedForecast = try decoder.decode(ForecastData.self, from: data!)
                }
                

                // Reload the table data in the main thread
                if decodedForecast != nil {
                    DispatchQueue.main.async {
                        self.delegate?.didFetchWeatherData(decodedForecast)
                    }
                } else {
                    // Even if the network is off, you still might end up here, so this condition gives an error message should the network be off
                    DispatchQueue.main.async {
                        self.delegate?.didFetchWeatherData(nil)
                    }
                }
            } catch {
                print("Error: ", error)
                // Error handling
                self.delegate?.didFetchWeatherData(nil)
            }
        }
        
        task.resume()
    }
}
