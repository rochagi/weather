//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Giovanna Rocha on 28/11/23.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "HourlyCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .green 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
