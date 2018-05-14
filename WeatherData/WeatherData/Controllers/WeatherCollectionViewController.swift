//
//  WeatherCollectionViewController.swift
//  WeatherData
//
//  Created by NURZHAN on 05.04.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography
import SwiftVideoBackground

protocol DefaultCities {
    var citiesArray: [City] {get set}
}

class WeatherCollectionViewController: UIViewController, DefaultCities {
    
//    MARK: Properties
    
    lazy var backgrounImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "weatherWall"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var citiesArray: [City] = []
    
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchOtherCities))
        return button
    }()
    
    lazy var citiesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.organize, target: self, action: #selector(getCitiesList))
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mainCellReuseIdentifier)
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

//    MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupNavigationBar()
        setupViews()
        addConstraints()
        
    }
    
    private func fetchData() {
        do {
            let result = try CoreDataConstants.context.fetch(City.fetchRequest())
            citiesArray = result as! [City]
        } catch let error {
            print(error)
        }
    }
    
    private func setupViews() {
        
        view.addSubViews([collectionView])
        view.insertSubview(backgrounImage, at: 0)
        
    }
    
    private func setupNavigationBar() {
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))!
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.insertSubview(visualEffectView, at: 0)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItems = [searchButton, citiesButton]
        
    }
    
//    MARK: Constraints
    
    private func addConstraints() {
        
        constrain(view, collectionView, backgrounImage) { v1, v2, v3 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
            
            v3.width == v1.width
            v3.height == v1.height
            v3.center == v1.center
        }
        
        
    }
    
    @objc private func searchOtherCities() {
        let controller = ViewController()
        controller.defaultCities = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func getCitiesList() {
        let controller = ReservedCityController()
        controller.defaultCities = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//    MARK: Flow Layout Delegate

extension WeatherCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        return itemSize
    }
    
}

//    MARK: Collection View Layout

extension WeatherCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if citiesArray.count == 0 {
            collectionView.alpha = 0
        } else {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        }
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mainCellReuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
        
//        cell.defaultCityName = citiesArray[indexPath.row]
        cell.getInformationWeather(defaultCityName: citiesArray[indexPath.row].cityName!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

