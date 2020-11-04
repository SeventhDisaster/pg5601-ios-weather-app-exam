//
//  InstantDetails.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - InstantDetails
struct InstantDetails: Codable {
    let airPressureAtSeaLevel, airTemperature, cloudAreaFraction, relativeHumidity: Double
    let windFromDirection, windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}
