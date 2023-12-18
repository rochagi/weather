//
//  ViewController.swift
//  Weather
//
//  Created by Giovanna Rocha on 23/11/23.
//

import UIKit

class ViewController: UIViewController {

    
  
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.contrastColor
        view.layer.cornerRadius = 20
        return view
    }()
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        
        label.textAlignment = .center
        label.textColor = UIColor.primaryColor
        return label
    }()
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        
        label.textAlignment = .left
        label.textColor = UIColor.primaryColor
        return label
    }()
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sunIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umidade"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vento"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var infosStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.softGray
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        return stackView
    }()
    private lazy var labelHora: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.text = "previsão por hora".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    private lazy var houryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.indentifier)
        return collectionView
    }()
    private lazy var labeldaily: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.text = "próximos dias".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    private lazy var dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        return tableView
    }()
    
    private let service = Service()
    private var city = City(lat: "-23.6814346", lon: "-46.9249599", name: "São Paulo")
    private var forecastResponse: ForecastResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchData()
       
    }
    
    private func fetchData(){
        service.fetchData(city: city){ [weak self] response in
            self?.forecastResponse = response
            DispatchQueue.main.async {
                self?.loadData()
            }
            
            
        }
    }
    private func loadData(){
        cityLabel.text = city.name
        temperatureLabel.text = forecastResponse?.current.temp.toCelsius()
        humidityValueLabel.text = "\(forecastResponse?.current.humidity ?? 0)mm"
        windValueLabel.text = "\(forecastResponse?.current.windSpeed ?? 0)km/h"
        houryCollectionView.reloadData()
        dailyTableView.reloadData()
    }
    
    private func setUpView(){
        
        setHierarchy()
        setConstrains()
        

        
    }
    private func setHierarchy(){
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(infosStackView)
        view.addSubview(labelHora)
        view.addSubview(houryCollectionView)
        view.addSubview(labeldaily)
        view.addSubview(dailyTableView)
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windValueLabel)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        infosStackView.addArrangedSubview(humidityStackView)
        infosStackView.addArrangedSubview(windStackView)
    }
    
    private func setConstrains(){
        backgroundView.setConstraintsToParents(view)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 71),
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 8)
        ])
        NSLayoutConstraint.activate([
            infosStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            infosStackView.widthAnchor.constraint(equalToConstant: 206),
            infosStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            labelHora.topAnchor.constraint(equalTo: infosStackView.bottomAnchor, constant: 29),
            labelHora.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            houryCollectionView.topAnchor.constraint(equalTo: labelHora.bottomAnchor, constant: 22),
            houryCollectionView.heightAnchor.constraint(equalToConstant: 84),
            houryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            houryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            labeldaily.topAnchor.constraint(equalTo: houryCollectionView.bottomAnchor, constant: 29),
            labeldaily.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyTableView.topAnchor.constraint(equalTo: labeldaily.bottomAnchor, constant: 16),
            dailyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.indentifier, for: indexPath) as? HourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        let forecast = forecastResponse?.hourly[indexPath.row]
        cell.loadData(time: forecast?.dt.toHourFormat(), icon: UIImage(named: "sunIcon"), temp: forecast?.temp.toCelsius())
         
        return cell
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else{
            return UITableViewCell()
        }
        let forecast = forecastResponse?.daily[indexPath.row]
        cell.loadData(weekDay: forecast?.dt.toWeekdayName(), min: forecast?.temp.min.toCelsius(), max: forecast?.temp.max.toCelsius(), icon: UIImage(named:"sunIcon"))
                
        return cell
    }
}
