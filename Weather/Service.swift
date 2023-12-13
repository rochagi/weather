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
    private let APIKey: String = "667819d127791399e96e84cc273db303"
    private let session = URLSession.shared
    
    func fetchData(city: City, _ completion: @escaping (ForecastResponse?) -> Void){
        let URLString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(APIKey)&units=metric"
        
        guard let url = URL(string: URLString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data else{
                completion(nil)
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(forecastResponse)
            } catch {
                print(String(data: data, encoding: .utf8) ?? "")
                completion(nil)
                print(URLString)
            }
            
            
        }
        task.resume()
        
    }
    
}

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case current, hourly, daily
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
