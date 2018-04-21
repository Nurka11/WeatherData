//
//  WeatherViewController.swift
//  WeatherData
//
//  Created by NURZHAN on 19.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography
import Foundation
import SwiftVideoBackground

class WeatherCollectionViewCell: UICollectionViewCell {
    
//    MARK: Properties
    
    var weather: WeatherGetData?
    
    var currentCityName: String?
    
    private var weatherIcons: [String : UIImage] = [
        "Cloudy" : #imageLiteral(resourceName: "sky"),
        "Sunny" : #imageLiteral(resourceName: "sunny"),
        "Rain" : #imageLiteral(resourceName: "rain")
    ]
    
    let player = VideoBackground()
    
    private var weatherVideo: [String : String] = [
        "Clear" : "https://assets.calm.com/ec430076eb0ac1b7d31d0770246eb1d1.mp4",
        "Rain" : "https://assets.calm.com/1e3734bbdb4927e21072c59e856e3ccb.mp4",
        "Rain2" : "https://assets.calm.com/fea14a3cf74fe19bdaf09150bde4a66e.mp4",
        "Intermittent clouds" : "https://assets.calm.com/1578b34e624639ab51634d550e6ed8eb.mp4",
        "Cloudy" : "https://assets.calm.com/766ccc5e1024264ebd67445eda2fe712.mp4",
        "Mostly cloudy" : "https://assets.calm.com/602f74eb513448d66ecec302b23aabdc.mp4",
        "Sunny2" : "https://assets.calm.com/db43ece896d33c2cca61eb92e7f7ad03.mp4",
        "Smoke" : "https://assets.calm.com/e8ebb91d6d60b9ba887c5a7b850444c9.mp4",
        "Sunny" : "https://assets.calm.com/f601bec6ad901e552a2ef4c05722dd59.mp4",
        "Mostly cloudy w/ showers" : "https://assets.calm.com/f601bec6ad901e552a2ef4c05722dd59.mp4"
    ]
    
    private var weatherOwnVideo: [String : String] = [
        "Clear" : "clear",
        "Rain" : "https://assets.calm.com/1e3734bbdb4927e21072c59e856e3ccb.mp4",
        "Rain2" : "https://assets.calm.com/fea14a3cf74fe19bdaf09150bde4a66e.mp4",
        "Intermittent clouds" : "https://assets.calm.com/1578b34e624639ab51634d550e6ed8eb.mp4",
        "Cloudy" : "https://assets.calm.com/766ccc5e1024264ebd67445eda2fe712.mp4",
        "Mostly clear" : "mostlyClear",
        "Sunny2" : "https://assets.calm.com/db43ece896d33c2cca61eb92e7f7ad03.mp4",
        "Smoke" : "https://assets.calm.com/e8ebb91d6d60b9ba887c5a7b850444c9.mp4",
        "Sunny" : "https://assets.calm.com/f601bec6ad901e552a2ef4c05722dd59.mp4",
        "Mostly cloudy w/ showers" : "https://assets.calm.com/f601bec6ad901e552a2ef4c05722dd59.mp4"
    ]
    
    lazy var cityName: UILabel = {
        let label = UILabel()
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
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()

    lazy var weatherType: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    lazy var subCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "subCell")
        return collectionView
    }()
    
//    MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews([ cityName, temperatureLabel, weatherType, humidityLabel, windSpeedLabel, subCollectionView])
      
        addConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Get Request
    func getInformationWeather(defaultCityName: String) {
        weather = WeatherGetData(defaultCityName) {
            self.setInformation()
        }
    }
    
    private func setInformation() {
        let modelWeather = weather!.TodaysWeatherData

//        let url = URL(string: weatherVideo[modelWeather.WeatherDescription]!)!
//
//        player.play(view: self, url: url)
        try? player.play(view: self, videoName: weatherOwnVideo[modelWeather.WeatherDescription]!, videoType: "mp4")
        print(modelWeather.WeatherDescription)
        
        cityName.text = modelWeather.CityName
        let str = NSString(format: "%.1f", Double(modelWeather.Temperature)!)
        temperatureLabel.text = "\(str)"
        let str2 = NSString(format: "%.1f", Double(modelWeather.WindSpeed)!)
        windSpeedLabel.text = "Wind speed \(str2)m/s"
        weatherType.text = modelWeather.WeatherDescription
        
        currentCityName = modelWeather.CityName
        startTimerUpdata()
    }
    
//    MARK: Constraints
    private func addConstraints() {
        
        constrain(self, cityName) { v1, v2 in
            v2.width == v1.width
            v2.height == 50
            v2.centerX == v1.centerX
            v2.top == v1.top + self.bounds.height / 10
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
        
        constrain(self, subCollectionView) { v1, v2 in
            v2.width == v1.width
            v2.height == v1.height * 0.25
            v2.bottom == v1.bottom
            v2.centerX == v1.centerX
        }
        
    }
    
    private func startTimerUpdata() {
//        let timer = Timer.scheduledTimer(timeInterval: TimeInterval.init(10000), target: self, selector: #selector(upDataWeatherData), userInfo: nil, repeats: true)
        
//        timer.fire()
    }
    
    @objc private func upDataWeatherData() {
        getInformationWeather(defaultCityName: currentCityName!)
    }
    
}

extension WeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.bounds.width / 4
        let height = self.bounds.height * 0.25
        let size = CGSize(width: width, height: height)
        return size
    }
    
}

extension WeatherCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath) as! WeatherSubCollectionViewCell
//        cell.backgroundColor = .clear
//
//        cell.dayImage.image = weatherIcons["Sunny"]
//        cell.dayLabel.text = "Sunny"
        
        let cell = UICollectionViewCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


