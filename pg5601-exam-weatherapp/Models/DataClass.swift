//
//  DataClass.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let instant: Instant
    let next12_Hours: Next12_Hours?
    let next1_Hours, next6_Hours: NextHours?

    enum CodingKeys: String, CodingKey {
        case instant
        case next12_Hours = "next_12_hours"
        case next1_Hours = "next_1_hours"
        case next6_Hours = "next_6_hours"
    }
}
