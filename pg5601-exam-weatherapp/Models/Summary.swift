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

public enum SymbolCode: String, Codable {
    case clearskyDay = "clearsky_day"
    case clearskyNight = "clearsky_night"
    case cloudy = "cloudy"
    case fairDay = "fair_day"
    case fairNight = "fair_night"
    case partlycloudyDay = "partlycloudy_day"
    case partlycloudyNight = "partlycloudy_night"
}
