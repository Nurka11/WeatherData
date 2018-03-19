//
//  WeatherModel.swift
//  WeatherData
//
//  Created by NURZHAN on 16.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation

class WeatherModel {
    private var temp = String()
    private var humidity = String()
    private var windSpeed = String()
    private var sunriseTime = String()
    private var sunsetTime = String()
    private var cityName = String()
    private var weatherDescription = String()
    private var currentDate = NSDate()
    
    init(_ temp: String, _ humidity: String, _ windSpeed: String, _ sunriseTime: String, _ sunsetTime: String, _ cityName: String, _ currentDate: NSDate, _ weatherDescription: String) {
        
        self.temp = temp
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.currentDate = currentDate
        self.cityName = cityName
        self.weatherDescription = weatherDescription
        
    }
    
    public var Temperature: String {
        get{
            return temp
        }
    }
    
    public var Humidity: String {
        get{
            return humidity
        }
    }
    
    public var WindSpeed: String {
        get{
            return windSpeed
        }
    }
    
    public var SunriseTime: String {
        get{
            return sunriseTime
        }
    }
    
    public var SunsetTime: String {
        get{
            return sunsetTime
        }
    }
    
    public var CityName: String {
        get{
            return cityName
        }
    }
    
    public var CurrentDate: NSDate {
        get{
            return currentDate
        }
        set{
            currentDate = newValue
        }
    }
    
    public var WeatherDescription: String {
        get{
            return weatherDescription
        }
        set{
            weatherDescription = newValue
        }
    }
    
}
