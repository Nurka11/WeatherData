//
//  ReservedCityController.swift
//  WeatherData
//
//  Created by NURZHAN on 14.05.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography

class ReservedCityController: UIViewController {
    
//    MARK: Properties
    
    public var defaultCities: DefaultCities?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cityListCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addConstraints()
        
    }
    
    private func setupViews() {
        
        view.addSubViews([tableView])
        navigationItem.title = "Cities"
    }
    
//    MARK: Constraints
    private func addConstraints() {
        
        constrain(view, tableView) { v1, v2 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
        }
        
    }
    
}

extension ReservedCityController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (defaultCities?.citiesArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityListCellIdentifier, for: indexPath)
        
        let currentCity = (defaultCities?.citiesArray[indexPath.row])!
        
        cell.textLabel?.text = currentCity.cityName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            CoreDataConstants.context.delete((defaultCities?.citiesArray[indexPath.item])!)
            defaultCities?.citiesArray.remove(at: indexPath.row)
            tableView.reloadData()
            do {
                try CoreDataConstants.context.save()
            } catch let error {
                print(error)
            }
            break
        default:
            break
        }
    }
    
}
