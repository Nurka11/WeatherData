//
//  WeatherModel.swift
//  WeatherData
//
//  Created by NURZHAN on 16.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherModel {
    
    private var temp: String?
    private var windSpeed: String?
    private var sunriseTime: String?
    private var sunsetTime: String?
    private var cityName: String?
    private var weatherDescription: String?
    private var today: String?
    private var currentDate: String?
    
    init(temp: String, windSpeed: String, sunriseTime: String, sunsetTime: String, cityName: String, weatherDescription: String, today: String, currentDate: String) {
        self.temp = temp
        self.windSpeed = windSpeed
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.cityName = cityName
        self.weatherDescription = weatherDescription
        self.today = today
        self.currentDate = currentDate
    }
    
    public var Temperature: String {
        get{
            return temp!
        }
    }
    
    public var WindSpeed: String {
        get{
            return windSpeed!
        }
    }
    
    public var SunriseTime: String {
        get{
            return sunriseTime!
        }
    }
    
    public var SunsetTime: String {
        get{
            return sunsetTime!
        }
    }
    
    public var CityName: String {
        get{
            return cityName!
        }
        set {
            cityName = newValue
        }
    }
    
    public var CurrentDate: String {
        get{
            return currentDate!
        }
        set{
            currentDate = newValue
        }
    }
    
    public var WeatherDescription: String {
        get{
            return weatherDescription!
        }
        set{
            weatherDescription = newValue
        }
    }
    
}
