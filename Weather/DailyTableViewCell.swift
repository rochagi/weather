//
//  DailyTableViewCell.swift
//  Weather
//
//  Created by Giovanna Rocha on 01/12/23.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    static let identifier: String = "dailyForecast"
    
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
