//
//  WeatherDaysModel.swift
//  WeatherData
//
//  Created by NURZHAN on 29.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class WeatherDaysModel: Mappable {
    
    private var daysWeather: WeatherModel?
    private var date: String?
    private var day: NSDictionary?
    private var night: NSDictionary?
    private var sun: NSDictionary?
    private var temperature: NSDictionary?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        date <- map["Date"]
        day <- map["Day"]
        night <- map["Night"]
        sun <- map["Sun"]
        temperature <- map["Temperature"]
        
        fillingDataArray()
    }
    
    private func fillingDataArray() {
        let maxTemp = Int(truncating: (temperature!["Maximum"] as! NSDictionary)["Value"] as! NSNumber)
        let minTemp = Int(truncating: (temperature!["Minimum"] as! NSDictionary)["Value"] as! NSNumber)
        let temp = "\(maxTemp)º/\(minTemp)º"
        
        let wind = Double(truncating: ((day!["Wind"] as! NSDictionary)["Speed"] as! NSDictionary)["Value"] as! NSNumber)
        let windSpeed = "\(wind) km/h"
        
        let sunriseTime = sun!["Rise"] as! String
        
        let sunsetTime = sun!["Set"] as! String
        
        let weatherDescription = day!["IconPhrase"] as! String
        
        let today = date!
        
        let currentTime = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        
        let weather = WeatherModel(temp: temp, windSpeed: windSpeed, sunriseTime: sunriseTime, sunsetTime: sunsetTime, cityName: "Almaty", weatherDescription: weatherDescription, today: today, currentDate: currentTime)
        
        daysWeather = weather
    }
    
    public var fiveDayWeather: WeatherModel {
        get {
            return daysWeather!
        }
    }
    
}
