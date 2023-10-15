//
//  NetworkManager .swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation
import CoreLocation


enum RequestType: String {
    case GET
    case POST
}


final class NetworkManager {
    
    // MARK: - Properties

    let weathDayUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3186c0d06f570f4f5d7d652f075465e8&&units=metric"
    
    static let shared = NetworkManager()
    
    
    // MARK: - Weather Data Fetch
    
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weathDayUrl)&q=\(city)"
        sendRequest(with: urlString, ReqestType: RequestType.GET, decodType: WeatherData.self, completion: completion)
    }
    
    func fetchWeatherWeekData(city: String, copmletion: @escaping (Result<WeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=3186c0d06f570f4f5d7d652f075465e8"
        sendRequest(with: urlString, ReqestType: RequestType.GET, decodType: WeekData.self, completion: copmletion)
    }
    
    func fetchWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weathDayUrl)&lat=\(lat)&lon=\(lon)"
        sendRequest(with: urlString, ReqestType: RequestType.GET, decodType: WeatherData.self, completion: completion)
    }

    
    func fetchWeekWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Result<WeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?&lat=\(lat)&lon=\(lon)&appid=3186c0d06f570f4f5d7d652f075465e8"
        sendRequest(with: urlString, ReqestType: RequestType.GET, decodType: WeekData.self, completion: completion)
    }
    
    // MARK: - Network Request
    
    func sendRequest<T:Codable>(with url: String, ReqestType: RequestType, decodType: T.Type, completion: @escaping (Result<T, Error>) -> Void){
        guard let url = URL(string: url) else {
            completion(.failure(CustomeError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = ReqestType.rawValue
        
        let task =  URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(CustomeError.networkError(error.localizedDescription)))
                } else {
                    completion(.failure(CustomeError.unknown))
                }
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(CustomeError.decodingError(error.localizedDescription)))
            }
        }
        task.resume()
    }
}
