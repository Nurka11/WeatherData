//
//  TodaysModel.swift
//  WeatherData
//
//  Created by NURZHAN on 29.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import  ObjectMapper

class TodaysWeatherModel: Mappable {
    
    private var iconPhrase: String?
    private var humidity: String?
    private var temperature: NSDictionary?
    private var windSpeed: NSDictionary?
    private var todaysWeather: WeatherModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        iconPhrase <- map["IconPhrase"]
        humidity <- map["RelativeHumidity"]
        temperature <- map["Temperature"]
        
        windSpeed <- map["Wind"]
        
        let tempValue = temperature!["Value"]
        let windSpeedValue = (windSpeed!["Speed"] as! NSDictionary)["Value"]
        
        todaysWeather = WeatherModel(temp: "\(tempValue!)", windSpeed: "\(windSpeedValue!)", sunriseTime: "", sunsetTime: "", cityName: "", weatherDescription: iconPhrase!, today: "", currentDate: "")
        
    }
    
    public var todaysWeatherModel: WeatherModel {
        get {
            return todaysWeather!
        }
    }
    
}
