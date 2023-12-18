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
        label.textColor = UIColor.contrastColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    private lazy var minDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    private lazy var maxDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weekDayLabel, iconImageView, minDayLabel, maxDayLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.spacing = 15
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(weekDay: String?, min:String?, max: String?, icon: UIImage?){
        weekDayLabel.text = weekDay?.uppercased()
        minDayLabel.text = "min \(min ?? "")".uppercased()
        maxDayLabel.text = "max \(max ?? "")".uppercased()
        iconImageView.image = icon
    }
    
    private func setupView(){
        backgroundColor = .clear
        selectionStyle = .none
        setHierarchy()
        setConstraints()
    }
    private func setHierarchy(){
        contentView.addSubview(stackView)
        
    }
    private func setConstraints(){
        stackView.setConstraintsToParents(contentView)
        NSLayoutConstraint.activate([
            weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 77),
        ])
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
}
