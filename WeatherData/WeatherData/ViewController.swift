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
    
    var getData: WeatherGetData?
    
    var weathers: [WeatherModel] = []
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "wall"))
        return image
    }()

    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "What's the weather?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your city"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var cityName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city Name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 7
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.delegate = self
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
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
    
    lazy var historyButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(openHistoryVC))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = historyButton
        view.addSubViews([backgroundImage, mainLabel, subLabel, cityName, submitButton, dataView])
        
        submitButton.addSubview(activityLoader)
        
        addConstraints()
    }
    
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
    
    @objc private func openHistoryVC() {
        let controller = HistoryViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func showInfoWeather() {
        dataView.text = ""
        submitButton.setTitle("", for: .normal)
        setupActivityLoader()

        getData = WeatherGetData(cityName.text!, completion: {
            self.setDescriptions()
        })
    }
    
    private func setDescriptions() {
        
        if (!(getData?.ReadyDate)!) {
            let alertController = UIAlertController(title: "Error", message: "Fill the correct name", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            let weatherData = getData!.WeatherData
            dataView.text = "Temperature: \(weatherData.Temperature)\nHumidity: \(weatherData.Humidity)\nWind speed: \(weatherData.WindSpeed)\nSunrise Time: \(weatherData.SunriseTime)\nSunset Time: \(weatherData.SunsetTime)"
            
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
        }
        
        activityLoader.stopAnimating()
        submitButton.setTitle("Submit", for: .normal)
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

