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
