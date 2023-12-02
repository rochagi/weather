//
//  DailyTableViewCell.swift
//  Weather
//
//  Created by Giovanna Rocha on 01/12/23.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
