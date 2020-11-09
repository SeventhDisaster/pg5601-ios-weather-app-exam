//
//  WeatherConverter.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 04/11/2020.
//

import Foundation

func symbolCodeToWeather(symbolCode : SymbolCode) -> String {
    
    let reducedCode = symbolCode.rawValue
    
    // Writing is suffering
    switch reducedCode {
    case "clearsky_day", "clearsky_night":
        return "Clear Skies"
    case "cloudy" :
        return "Cloudy"
    case "fair_day", "fair_night" :
        return "Fair"
    case "fog":
        return "Fog"
    case "heavyrain":
        return "Heavy Rain"
    case "heavyrainandthunder":
        return "Heavy Rain and Thunder"
    case "heavyrainshower_day", "heavyrainshower_night" :
        return "Heavy Rain Shower"
    case "heavyrainshowersandthunder_day", "heavyrainshowersandthunder_night" :
        return "Heavy Rainshowers and Thunder"
    case "heavysleet" :
        return "Heavy Sleet"
    case "heavysleetandthunder" :
        return "Heavy Sleet and Thunder"
    case "heavysleetshowers_day", "heavysleetshowers_night" :
        return "Heavy Sleet Showers"
    case "heavysleetshowersandthunder_day", "heavysleetshowersandthunder_night":
        return "Heavy Sleetshowers and Thunder"
    case "heavysnow" :
        return "Heavy Snow"
    case "heavysnowandthunder" :
        return "Heavy Snow and Thunder"
    case "heavysnowshowers_day", "heavysnowshowers_night" :
        return "Heavy Snow Showers"
    case "heavysnowshowersandthunder_day", "heavysnowshowersandthunder_night" :
        return "Heavy snow showers and thunder"
    case "lightrain" :
        return "Light Rain"
    case "lightrainandthunder" :
        return "Light Rain and Thunder"
    case "lightrainshowers_day", "lightrainshowers_night" :
        return "Light Rain showers"
    case "lightrainshowersandthunder_day", "lightrainshowersandthunder_night" :
        return "Light Rainshowers and thunder"
    case "lightsleet" :
        return "Light Sleet"
    case "lightsleetandthunder" :
        return "Light Sleet and thunder"
    case "lightsleetshowers_day", "lightsleetshowers_night" :
        return "Light Sleet showers"
    case "lightssleetshowersandthunder_day", "lightssleetshowersandthunder_night" :
        return "Light Sleet showers and thunder"
    case "lightsnow" :
        return "Light Snow"
    case "lightsnowandthunder" :
        return "Light Snow and Thunder"
    case "lightsnowshowers_day", "lightsnowshowers_night" :
        return "Light Snow Showers"
    case "lightsnowshowersandthunder_day","lightsnowshowersandthunder_night":
        return "Light Snow showers and thunder"
    case "partlycloudy_day", "partlycloudy_night":
        return "Partly Cloudy"
    case "rain" :
        return "Rain"
    case "rainandthunder" :
        return "Rain and Thunder"
    case "rainshowers_day", "rainshowers_night" :
        return "Rain Showers"
    case "rainshowersandthunder_day", "rainshowersandthunder_night" :
        return "Rain Showers and thunder"
    case "sleet" :
        return "Sleet"
    case "sleetandthunder" :
        return "Sleet and Thunder"
    case "sleetshowers_day", "sleetshowers_night" :
        return "Sleet showers"
    case "sleetshowersandthunder_day", "sleetshowersandthunder_night" :
        return "Sleet showers and thunder"
    case "snow" :
        return "Snow"
    case "snowandthunder" :
        return "Snow and thunder"
    case "snowshowers_day", "snowshowers_night" :
        return "Snow showers"
    case "snowshowersandthunder_day", "snowshowersandthunder_night" :
        return "Snow showers and thunder"
    default:
        return "Unrecognized Weather"
    }
}
