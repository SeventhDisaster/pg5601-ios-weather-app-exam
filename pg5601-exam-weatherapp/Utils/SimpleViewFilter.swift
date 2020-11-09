//
//  SimpleViewFilter.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 07/11/2020.
//

import Foundation

// This function will run through the result from an API call and parse out the 7 next days of weather report
func parseForecastToSimpleWeekData(data: Properties) -> [SimpleWeatherData] {
    var list : [SimpleWeatherData] = []
    let updateDateTime = timeStringToReadable(timeString: data.meta.updatedAt) // Time the data was updated
    
    //Sets up the 7 day 6AM list
    for day in filterOutDays(timeseries: data.timeseries){
        let weekday = timeStringToWeekday(timeString: day.time)
        if day.data.next6_Hours != nil {
            list.append(SimpleWeatherData(updateTime: updateDateTime, day: weekday, nextHours: day.data.next6_Hours!))
        } else {
            list.append(SimpleWeatherData(updateTime: updateDateTime, day: weekday, nextHours: day.data.next1_Hours!))
        }
        
    }
    return list
}

func timeStringToReadable(timeString: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    return dateFormatter.string(from: timeString)
}

// Note: There are probably many better ways of implementing this filtering down to individual days, I just couldn't find any

//Filters out extravenous times (Getting one per day)
func filterOutDays(timeseries: [Timesery]) -> [Timesery] {
    var selections : [Timesery] = []
    var usedDates : [Int] = [] //This is used to avoid going through the same day
    for sery in timeseries {
        //print(sery.time)
        if(!isDateInList(date: sery.time, list: usedDates)) {
            selections.append(sery)
            usedDates.append(Calendar.current.component(.day, from: sery.time))
        }
        
    }
    while selections.count > 7 {
        selections.removeLast() //Cut it down to the 7 first entries
    }
    return selections;
}

func isDateInList(date : Date, list : [Int]) -> Bool {
    let day = Calendar.current.component(.day, from: date)
    
    // Checks if the day is already used (If it is, skip to next)
    for existingDay in list {
        if existingDay == day {
            return true // Ensure only one day is selected from the array
        }
    }
    if Calendar.current.component(.hour, from: date) < 6 {
        return true //Wait until at least 8AM before selecting a time
    }
    return false
}

func timeStringToWeekday(timeString: Date) -> String {
    let weekday = Calendar.current.component(.weekday, from: timeString)
    switch weekday {
    case 1: return "Sunday"
    case 2: return "Monday"
    case 3: return "Tuesday"
    case 4: return "Wednesday"
    case 5: return "Thursday"
    case 6: return "Friday"
    case 7: return "Saturday"
        
    default:
        return "Undefined Day"
    }
}


