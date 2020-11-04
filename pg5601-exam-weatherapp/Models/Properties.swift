//
//  Properties.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 02/11/2020.
//

import Foundation

// MARK: - Properties
struct Properties: Codable {
    let meta: Meta
    let timeseries: [Timesery]
}
