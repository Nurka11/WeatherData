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
    var citiesArray: [String] {get set}
}

class WeatherCollectionViewController: UIViewController, DefaultCities {
    
//    MARK: Properties
    
    var citiesArray: [String] = ["Almaty", "Taiwan"]
    
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchOtherCities))
        return button
    }()
    
    lazy var citiesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.organize, target: self, action: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        addConstraints()
        
    }
    
    private func setupViews() {
        
        view.addSubViews([collectionView])
        
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
        
        constrain(view, collectionView) { v1, v2 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
        }
        
        
    }
    
    @objc private func searchOtherCities() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
}

//    MARK: Flow Layout Delegate

extension WeatherCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        return itemSize
    }
    
}

//    MARK: Colllection View Layout

extension WeatherCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mainCellReuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
        
//        cell.defaultCityName = citiesArray[indexPath.row]
        cell.getInformationWeather(defaultCityName: citiesArray[indexPath.row])
        
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

