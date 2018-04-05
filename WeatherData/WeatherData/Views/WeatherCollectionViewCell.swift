//
//  WeatherViewController.swift
//  WeatherData
//
//  Created by NURZHAN on 19.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography

class WeatherCollectionViewCell: UICollectionViewCell {
    
    var weather: WeatherGetData?
    
    private var weatherImage: [String : UIImage] = [
        "Rain" : UIImage(named: "rain")!,
        "Smoke" : UIImage(named: "smoke")!,
        "Clouds" : UIImage(named: "brokenClouds")!,
        "Clear" : UIImage(named: "clear")!
    ]
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "weatherWall"))
        image.contentMode = .scaleAspectFill
        image.contentMode = .center
        return image
    }()
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = "Almaty"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 84)
        return label
    }()

    lazy var weatherType: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews([backgroundImage, cityName, temperatureLabel, weatherType, humidityLabel, windSpeedLabel])
        
        addConstraints()
        
        getInformationWeather()
        
        UIView.animate(withDuration: 5, delay: 0, options: [.allowUserInteraction, .curveEaseOut, .repeat, .autoreverse], animations: {
            self.backgroundImage.transform = CGAffineTransform.init(translationX: 15, y: 0)
        }, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getInformationWeather() {
         weather = WeatherGetData("Almaty") {
            self.setInformation()
        }
    }
    
    private func setInformation() {
        let modelWeather = weather!.TodaysWeatherData
        backgroundImage.image = weatherImage[modelWeather.WeatherDescription]
        cityName.text = modelWeather.CityName
        temperatureLabel.text = modelWeather.Temperature
        windSpeedLabel.text = "Wind speed \(String(describing: modelWeather.WindSpeed))m/s"
        weatherType.text = modelWeather.WeatherDescription
    }
    
    private func addConstraints() {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        constrain(self, backgroundImage){ v1, v2 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
        }
        
        constrain(self, cityName) { v1, v2 in
            v2.width == v1.width
            v2.height == 50
            v2.centerX == v1.centerX
            v2.top == v1.top + self.bounds.height / 10 + statusBarHeight + 50
        }
        
        constrain(cityName, temperatureLabel, weatherType) { v1, v2, v3 in
            v2.width == (v2.superview?.width)!
            v2.height == self.bounds.height / 6
            v2.centerX == v1.centerX
            v2.top == v1.bottom + 20
            
            v3.height == v1.height
            v3.width == v1.width
            v3.centerX == v1.centerX
            v3.top == v2.bottom
        }
        
        constrain(weatherType, humidityLabel, windSpeedLabel) { v1, v2, v3 in
            v2.width == v1.width
            v2.height == 30
            v2.right == (v2.superview?.right)! - 20
            v2.top == v1.top + self.bounds.height / 8
            
            v3.width == v2.width
            v3.height == v2.height
            v3.top == v2.bottom
            v3.right == v2.right
        }
        
    }
    
}
