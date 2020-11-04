//
//  Units.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - Units
struct Units: Codable {
    let airPressureAtSeaLevel, airTemperature, cloudAreaFraction, precipitationAmount: String
    let relativeHumidity, windFromDirection, windSpeed: String

    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case precipitationAmount = "precipitation_amount"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}
