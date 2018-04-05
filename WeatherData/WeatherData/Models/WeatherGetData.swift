//
//  WeatherModel.swift
//  WeatherData
//
//  Created by NURZHAN on 15.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class WeatherGetData {

    private var readyData: Bool = false
    private var temp = String()
    private var humidity = String()
    private var windSpeed = String()
    private var sunriseTime = String()
    private var sunsetTime = String()
    private var cityName = String()
    private var currentDate = NSDate()
    private var weatherData: [WeatherDaysModel]?
    private var todaysWeatherData: WeatherModel?
    private var weatherDescription = String()
    
    private var cityId = 0
    
    
    private var locationKeyUrl = "http://dataservice.accuweather.com/locations/v1/search?q=Almaty&apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0"
    
    private var forecastFiveDaysUrl = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/222191?apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0&language=en&details=true&metric=true"
    
    private var forecastDayUrl = "http://dataservice.accuweather.com/forecasts/v1/hourly/1hour/222191?apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0&details=true&metric=true"
    
    private var openWeatherAppUrl = "http://api.openweathermap.org/data/2.5/weather?q=Almaty&appid=a644894d0dc1f4eb3f946b445c31dd30"
    
    init(_ cityName: String, completion : @escaping ()->()) {
        
        
        getCityId(cityName: cityName) {
            
            let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/1hour/\(self.cityId)?apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0&details=true&metric=true")!
            Alamofire.request(url).responseJSON { (responce) in
                switch responce.result {
                case .success(let responceString):
                    print(responceString)
                    let todaysWeather = Mapper<TodaysWeatherModel>().mapArray(JSONArray: ((responceString as! NSArray) as! [[String : Any]]))
                    self.todaysWeatherData = todaysWeather[0].todaysWeatherModel
                    self.todaysWeatherData?.CityName = cityName
                    completion()
                case .failure(let error):
                    print(error)
                }
            }

        }
        
    }
    
    init(_ cityName: String, fiveDay: Bool, completion : @escaping ()->()){
        
        getCityId(cityName: cityName) {
            
            let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(self.cityId)?apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0&language=en&details=true&metric=true")!
            print(self.cityId)
            Alamofire.request(url).responseJSON { (responce) in
                switch responce.result {
                case .success(let responceString):
                    let responceArray = (responceString as! NSDictionary)["DailyForecasts"]
                    let responseJSON = responceArray as? Array<[String: AnyObject]>
                    let array: [WeatherDaysModel] = Mapper<WeatherDaysModel>().mapArray(JSONArray: responseJSON!)
                    self.weatherData = array
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
    }
    
    private func getCityId (cityName: String, completion: @escaping () -> ()) {
        
        let url = URL(string: "http://dataservice.accuweather.com/locations/v1/search?q=\(cityName)&apikey=wsyWg15yDWAgztJLTzzxefpbx6DxQmr0")
        
        Alamofire.request(url!).responseJSON { (response) in
            switch response.result {
            case .success(let responceString):
                let responseDict = ((responceString as! NSArray)[0] as! NSDictionary)
                let cityKey = responseDict["Key"]! as! NSString
                self.cityId = Int(cityKey as String)!
                completion()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }

    public var WeatherData: [WeatherDaysModel] {
        get {
            return weatherData!
        }
    }
    
    public var TodaysWeatherData: WeatherModel {
        get {
            return todaysWeatherData!
        }
    }

    public var ReadyDate: Bool {
        get {
            return readyData
        }
    }
    
}
