//
//  DetailViewController.swift
//  WeatherData
//
//  Created by NURZHAN on 16.03.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    public var weatherData: DetailWeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.title = weatherData?.weather.CityName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
}
