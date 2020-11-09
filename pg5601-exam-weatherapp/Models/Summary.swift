//
//  Summary.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - Summary
struct Summary: Codable {
    let symbolCode: SymbolCode

    enum CodingKeys: String, CodingKey {
        case symbolCode = "symbol_code"
    }
}

// I felt only pain writing this manually

//NOTE: If placing a pin or viewing locations far north, may include polar twilight
public enum SymbolCode: String, Codable {
    case clearskyDay = "clearsky_day"
    case clearskyNight = "clearsky_night"
    case cloudy = "cloudy"
    case fairDay = "fair_day"
    case fairNight = "fair_night"
    case fog = "fog"
    case heavyRain = "heavyrain"
    case heavyRainAndThunder = "heavyrainandthunder"
    case heavyRainShowerDay = "heavyrainshower_day"
    case heavyRainShowerNight = "heavyrainshower_night"
    case heavyRainShowerPolartwilight = "heavyrainshower_polartwilight"
    case heavyRainShowersAndThunderDay = "heavyrainshowersandthunder_day"
    case heavyRainShowersAndThunderNight = "heavyrainshowersandthunder_night"
    case heavyRainShowersAndThunderPolartwilight = "heavyrainshowersandthunder_polartwilight"
    case heavySleet = "heavysleet"
    case heavySleetAndThunder = "heavysleetandthunder"
    case heavySleetShowersDay = "heavysleetshowers_day"
    case heavySleetShowersNight = "heavysleetshowers_night"
    case heavySleetShowersPolartwilight = "heavysleetshowers_polartwilight"
    case heavySleetShowersAndThunderDay = "heavysleetshowersandthunder_day"
    case heavySleetShowersAndTHunderNight = "heavysleetshowersandthunder_night"
    case heavySleetShowersAndTHunderPolartwilight = "heavysleetshowersandthunder_polartwilight"
    case heavySnow = "heavysnow"
    case heavySnowAndThunder = "heavysnowandthunder"
    case heavySnowShowersDay = "heavysnowshowers_day"
    case heavySnowShowersNight = "heavysnowshowers_night"
    case heavySnowShowersPolartwilight = "heavysnowshowers_polartwilight"
    case heavySnowShowersAndThunderDay = "heavysnowshowersandthunder_day"
    case heavySnowShowersAndThunderNight = "heavysnowshowersandthunder_night"
    case heavySnowShowersAndThunderPolartwilight = "heavysnowshowersandthunder_polartwilight"
    case lightRain = "lightrain"
    case lightRainAndThunder = "lightrainandthunder"
    case lightRainShowersDay = "lightrainshowers_day"
    case lightRainShowersNight = "lightrainshowers_night"
    case lightRainShowersPolartwilight = "lightrainshowers_polartwilight"
    case lightRainShowersAndThunderDay = "lightrainshowersandthunder_day"
    case lightRainShowersAndThunderNight = "lightrainshowersandthunder_night"
    case lightRainShowersAndThunderPolartwilight = "lightrainshowersandthunder_polartwilight"
    case lightSleet = "lightsleet"
    case lightSleetAndThunder = "lightsleetandthunder"
    case lightSleetShowersDay = "lightsleetshowers_day"
    case lightSleetShowersNight = "lightsleetshowers_night"
    case lightSleetShowersPolartwilight = "lightsleetshowers_polartwilight"
    case lightSleetShowersAndThunderDay = "lightsleetshowersandthunder_day"
    case lightSleetShowersAndThunderNight = "lightsleetshowersandthunder_night"
    case lightSleetShowersAndThunderPolartwilight = "lightsleetshowersandthunder_polartwilight"
    case lightSnow = "lightsnow"
    case lightSnowAndThunder = "lightsnowandthunder"
    case lightSnowShowersDay = "lightsnowshowers_day"
    case lightSnowShowersNight = "lightsnowshowers_night"
    case lightSnowShowersPolartwilight = "lightsnowshowers_polartwilight"
    case lightSnowShowersAndThunderDay = "lightssnowshowersandthunder_day"
    case lightSnowShowersAndThunderNight = "lightssnowshowersandthunder_night"
    case lightSnowShowersAndThunderPolartwilight = "lightssnowshowersandthunder_polartwilight"
    case partlycloudyDay = "partlycloudy_day"
    case partlycloudyNight = "partlycloudy_night"
    case partlycloudyPolartwilight = "partlycloudy_polartwilight"
    case rain = "rain"
    case rainAndThunder = "rainandthunder"
    case rainShowersDay = "rainshowers_day"
    case rainShowersNight = "rainshowers_night"
    case rainShowersPolartwilight = "rainshowers_polartwilight"
    case rainShowersAndThunderDay = "rainshowersandthunder_day"
    case rainShowersAndThunderNight = "rainshowersandthunder_night"
    case rainShowersAndThunderPolartwilight = "rainshowersandthunder_polartwilight"
    case sleet = "sleet"
    case sleetAndThunder = "sleetandthunder"
    case sleetShowersDay = "sleetshowers_day"
    case sleetShowersNight = "sleetshowers_night"
    case sleetShowersPolartwilight = "sleetshowers_polartwilight"
    case sleetShowersAndThunderDay = "sleetshowersandthunder_day"
    case sleetShowersAndThunderNight = "sleetshowersandthunder_night"
    case sleetShowersAndThunderPolartwilight = "sleetshowersandthunder_polartwilight"
    case snow = "snow"
    case snowAndThunder = "snowandthunder"
    case snowShowersDay = "snowshowers_day"
    case snowShowersNight = "snowshowers_night"
    case snowShowersPolartwilight = "snowshowers_polartwilight"
    case snowShowersAndThunderDay = "snowshowersandthunder_day"
    case snowShowersAndThunderNight = "snowshowersandthunder_night"
    case snowShowersAndThunderPolartwilight = "snowshowersandthunder_polartwilight"
}
