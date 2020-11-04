//
//  WeatherConverter.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 04/11/2020.
//

import Foundation

func symbolCodeToWeather(symbolCode : SymbolCode) -> String {
    
    let reducedCode = symbolCode.rawValue.split(separator: "_")[0]
    
    switch reducedCode {
    case "clearsky": return "Clear Skies"
    case "cloudy": return "Cloudy"
    case "fair" : return "Fair"
    case "fog" : return "Fog"
    case "heavyrain" : return "Heavy Rain"
    case "heavyrainandthunder" : return "Thunderstorm"
    case "lightrain" : return "Light Rain"
    case "rain" : return "Rain"
    case "rainandthunder" : return "Thunder"
    case "snow": return "Snow"
    default: return "Undetermined"
    }
}
