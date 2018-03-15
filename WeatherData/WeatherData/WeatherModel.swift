//
//  WeatherModel.swift
//  WeatherData
//
//  Created by NURZHAN on 15.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import Alamofire

class WeatherModel {
    
    public var mainData: [String : String] = [:]
    public var readyData: Bool = false
    public var temp = String()
    public var humidity = String()
    public var windSpeed = String()
    public var sunriseTime = String()
    public var sunsetTime = String()
    public var cityName = String()
    public var currentData = NSDate()
    
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
                    self.mainData["Temperatura"] = self.temp
                    self.mainData["temp"] = self.temp
                    self.humidity = "\(String(describing: (resultDictionary["main"] as! NSDictionary)["humidity"]!))"
                    self.windSpeed = "\(String(describing: (resultDictionary["wind"] as! NSDictionary)["speed"]!))"
                    self.sunriseTime = "\(String(describing: (resultDictionary["sys"] as! NSDictionary)["sunrise"]!))"
                    self.sunsetTime = "\(String(describing: (resultDictionary["sys"] as! NSDictionary)["sunset"]!))"
                    
                    self.currentData = NSDate()
                    
                    self.readyData = true
                    completion()
                }
            }
        }
        
    }
    
}
