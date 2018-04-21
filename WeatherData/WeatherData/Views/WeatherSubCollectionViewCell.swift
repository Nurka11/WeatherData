//
//  WeatherSubCollectionViewCell.swift
//  WeatherData
//
//  Created by NURZHAN on 15.04.2018.
//  Copyright © 2018 NURZHAN. All rights reserved.
//

import UIKit
import Cartography

class WeatherSubCollectionViewCell: UICollectionViewCell {
    
//    MARK: Properties
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var dayImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
//    MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addConstraints()
        
    }
    
    private func setupViews() {
        
        self.addSubViews([dayLabel, dayImage])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func addConstraints() {
        
        constrain(self, dayImage, dayLabel) { v1, v3, v2 in
            v2.width == v1.width
            v2.height == v1.height * 0.3
            v2.centerX == v1.centerX
            v2.top == v1.top
            
            v3.width == v1.width
            v3.height == v1.height * 0.5
            v3.centerX == v1.centerX
            v2.bottom == v1.bottom
        }
        
    }
}
