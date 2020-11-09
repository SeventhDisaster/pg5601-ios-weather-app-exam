//
//  GlobalSettings.swift
//  pg5601-exam-weatherapp
//
//  Created by Candidate 10061 on 04/11/2020.
//

import Foundation

public var userLocation : (lat: Double, lon: Double)? = nil

// Having this delegate object public is probably not best practice, but It makes it easy to assign the delegate to a separate class
public let mapWeather = MapWeather()
