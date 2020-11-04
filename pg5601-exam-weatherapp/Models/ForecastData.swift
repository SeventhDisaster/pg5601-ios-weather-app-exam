//
//  ForecastData.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - ForecastData
struct ForecastData: Decodable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}
