//
//  Constants.swift
//  WeatherData
//
//  Created by NURZHAN on 05.04.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import CoreData

enum Constants {
    static let mainCellReuseIdentifier: String = "mainCell"
    static let subCellReuseIdentifier: String = "subCell"
    
    
    static let cityListCellIdentifier = "cellID"
}

enum SearchControllerConstants {
    static let mainLabelText = "What's the weather?"
    static let subLabelText = "Enter your city"
    static let cityNameText = "Enter city Name"
    static let submitButton = "Submit"
    static let saveButton = "Save"
    
    static let temperature = "Temperature"
    static let windSpeed = "Wind Speed"
    static let sunriseTime = "Sunrise Time"
    static let sunsetTime = "Sunset Time"
}

enum CoreDataConstants {
    static let entityName = "City"
    static let keyToSaving = "cityName"
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = CoreDataConstants.appDelegate.persistentContainer.viewContext
    static let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: CoreDataConstants.context)
    static let userData = NSManagedObject(entity: CoreDataConstants.entity!, insertInto: CoreDataConstants.context)
}
