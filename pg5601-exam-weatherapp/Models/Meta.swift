//
//  Meta.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - Meta
struct Meta: Codable {
    let updatedAt: Date
    let units: Units

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case units
    }
}
