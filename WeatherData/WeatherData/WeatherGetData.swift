//
//  WeatherModel.swift
//  WeatherData
//
//  Created by NURZHAN on 15.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import Alamofire

class WeatherGetData {

    private var readyData: Bool = false
    private var temp = String()
    private var humidity = String()
    private var windSpeed = String()
    private var sunriseTime = String()
    private var sunsetTime = String()
    private var cityName = String()
    private var currentDate = NSDate()
    private var weatherData: WeatherModel?
    
    init(_ cityName: String, completion : @escaping ()->()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=a644894d0dc1f4eb3f946b445c31dd30")!
        
        self.cityName = cityName
        
        Alamofire.request(url).responseJSON { (responce) in
            if let result = responce.result.value {
                print(result)
                
                let resultDictionary  = result as! NSDictionary
                
                if(resultDictionary["main"] == nil){
                    completion()
                }
                else {
                    self.temp = "\(String(describing: (resultDictionary["main"] as! NSDictionary)["temp"]!))"
                    self.humidity = "\(String(describing: (resultDictionary["main"] as! NSDictionary)["humidity"]!))"
                    self.windSpeed = "\(String(describing: (resultDictionary["wind"] as! NSDictionary)["speed"]!))"
                    self.sunriseTime = "\(String(describing: (resultDictionary["sys"] as! NSDictionary)["sunrise"]!))"
                    self.sunsetTime = "\(String(describing: (resultDictionary["sys"] as! NSDictionary)["sunset"]!))"
                    
                    self.currentDate = NSDate()
                    
                    self.weatherData = WeatherModel(self.temp, self.humidity, self.windSpeed, self.sunriseTime, self.sunsetTime, self.cityName, self.currentDate)
                    
                    self.readyData = true
                    completion()
                }
            }
        }
        
    }

    public var WeatherData: WeatherModel {
        get{
            return weatherData!
        }
    }

    public var ReadyDate: Bool {
        get {
            return readyData
        }
    }
    
}
