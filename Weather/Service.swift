//
//  Service.swift
//  Weather
//
//  Created by Giovanna Rocha on 06/12/23.
//

import Foundation

struct City {
    let lat: String
    let lon: String
    let name: String
}

class Service {
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let APIKey: String = "2b75a26ac7e3392386bd92fecfad70d3"
    private let session = URLSession.shared
    
    func fetchData(city: City, _ completion: @escaping (String) -> Void){
        let URLString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(APIKey)"
        
        guard let url = URL(string: URLString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            completion("banana")
        }
        task.resume()
        
    }
    
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: jsonData)
// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case current, hourly, daily
    }
}

// MARK: - Alert
struct Alert: Codable {
    let senderName, event: String
    let start, end: Int
    let description: String
    let tags: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end, description, tags
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]


}
// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
