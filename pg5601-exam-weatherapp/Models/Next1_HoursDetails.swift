//
//  Next1_HoursDetails.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - Next1_HoursDetails
struct Next1_HoursDetails: Codable {
    let precipitationAmount: Float

    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}
