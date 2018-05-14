//
//  ViewController.swift
//  WeatherData
//
//  Created by NURZHAN on 15.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography
import Alamofire
import SwiftyJSON

protocol TableDataProtocol {
    var weathers: [WeatherModel] {get set}
}

class ViewController: UIViewController, TableDataProtocol, UITextFieldDelegate {
    
//    MARK: Properties
    var getData: WeatherGetData?
    
    var weathers: [WeatherModel] = []
    
    public var defaultCities: DefaultCities?
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "wallpaper"))
        return image
    }()

    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = SearchControllerConstants.mainLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = SearchControllerConstants.subLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var cityName: UITextField = {
        let textField = UITextField()
        textField.placeholder = SearchControllerConstants.cityNameText
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 7
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.delegate = self
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle(SearchControllerConstants.submitButton, for: .normal)
        button.backgroundColor = UIColor(red: 108/255, green: 193/255, blue: 117/255, alpha: 1)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(showInfoWeather), for: .touchUpInside)
        return button
    }()
    
    lazy var activityLoader: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.hidesWhenStopped = true
        return activity
    }()
    
    lazy var saveCity: UIBarButtonItem = {
        let button = UIBarButtonItem(title: SearchControllerConstants.saveButton, style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveCityName))
        return button
    }()
    
    lazy var dataView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = saveCity
        view.addSubViews([backgroundImage, mainLabel, subLabel, cityName, submitButton, dataView])
        
        submitButton.addSubview(activityLoader)
        
        addConstraints()
    }
    
//    MARK: Constraints
    private func addConstraints() {
        
        constrain(view, backgroundImage){ v1, v2 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
        }
        
        constrain(view, mainLabel, subLabel){ v1, v2, v3 in
            v2.width == v1.width
            v2.centerX == v1.centerX
            v2.top == v1.top + view.bounds.height/8
            
            v3.width == v1.width * 0.5
            v3.centerX == v1.centerX
            v3.top == v2.bottom + 20
        }
        
        constrain(subLabel, cityName){ v1, v2 in
            v2.width == (v2.superview?.width)! * 0.9
            v2.height == 30
            v2.centerX == v1.centerX
            v2.top == v1.bottom + 30
        }
        
        constrain(cityName, submitButton, dataView){ v1, v2, v3 in
            v2.width == v1.width / 2
            v2.height == 30
            v2.centerX == v1.centerX
            v2.top == v1.bottom + 15
            
            v3.width == (v3.superview?.width)! * 0.9
            v3.height == 20
            v3.height == (v3.superview?.height)! * 0.3
            v3.centerX == v2.centerX
            v3.top == v2.bottom + 20
        }
    
    }
    
    @objc private func saveCityName() {
        let savingCity = City(entity: CoreDataConstants.entity!, insertInto: CoreDataConstants.context)
        savingCity.setValue(cityName.text!, forKey: CoreDataConstants.keyToSaving)
        
        do {
            try CoreDataConstants.context.save()
            defaultCities?.citiesArray.append(savingCity)
        } catch let error {
            print(error)
        }
    }
    
    @objc private func showInfoWeather() {
        dataView.text = ""
        submitButton.setTitle("", for: .normal)
        setupActivityLoader()
        getData = WeatherGetData(cityName.text!, fiveDay: true, completion: {
            self.setDescriptions()
        })
    }
    
    private func setDescriptions() {
        let weatherData = getData!.WeatherData[0].fiveDayWeather
        dataView.text = "\(SearchControllerConstants.temperature): \(weatherData.Temperature)\n\(SearchControllerConstants.windSpeed): \(weatherData.WindSpeed)\n\(SearchControllerConstants.sunriseTime): \(weatherData.SunriseTime)\n\(SearchControllerConstants.sunsetTime): \(weatherData.SunsetTime)"
        
        let contains = weathers.contains(where: {
            return $0.CityName == weatherData.CityName
        })
        
        if(!contains){
            weathers.append(weatherData)
        }
        else {
            let index = weathers.index(where: {
                return $0.CityName == weatherData.CityName
            })
            
            weathers[index!].CurrentDate = weatherData.CurrentDate
        }
        activityLoader.stopAnimating()
        submitButton.setTitle(SearchControllerConstants.submitButton, for: .normal)
    }
    
    private func setupActivityLoader() {
        
        activityLoader.startAnimating()
        constrain(submitButton, activityLoader) { v1, v2 in
            v2.center == v1.center
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cityName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityName.resignFirstResponder()
        return true
    }
    
}

