//
//  SimpleWeatherData.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 07/11/2020.
//

import Foundation

struct SimpleWeatherData: Codable {
    public var updateTime: String?
    public var day : String?
    public var nextHours: NextHours
    
    init(updateTime: String, day: String, nextHours: NextHours) {
        self.updateTime = updateTime
        self.day = day
        self.nextHours = nextHours
    }
}
