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

struct ErrorResponse: Decodable {
    let error: String
}

final class NetworkManager {
    
    
    // MARK: - Properties
    
    let weathDayUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3186c0d06f570f4f5d7d652f075465e8&&units=metric"
    
    static let shared = NetworkManager()
    
    
    // MARK: - Weather Data Fetch
    
    func fetchWeatherData(city: String, copmletion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weathDayUrl)&q=\(city)"
        sendRequest(with: urlString, RequestType: RequestType.GET, decodingType: WeatherData.self, completion: copmletion)
    }
    
    func fetchWeatherWeekData(city: String, copmletion: @escaping (Result<WeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=3186c0d06f570f4f5d7d652f075465e8"
        sendRequest(with: urlString, RequestType: RequestType.GET, decodingType: WeekData.self, completion: copmletion)
    }
    
    func fetchWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weathDayUrl)&lat=\(lat)&lon=\(lon)"
        sendRequest(with: urlString, RequestType: RequestType.GET, decodingType: WeatherData.self, completion: completion)
    }
    
    
    func fetchWeekWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Result<WeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?&lat=\(lat)&lon=\(lon)&appid=3186c0d06f570f4f5d7d652f075465e8"
        sendRequest(with: urlString, RequestType: RequestType.GET, decodingType: WeekData.self, completion: completion)
    }
    
    // MARK: - Network Request
    
    func sendRequest<T: Codable>(with urlString: String, RequestType: RequestType, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    if let error = error {
                        completion(.failure(CustomeError.networkError(error.localizedDescription)))
                        print(error)
                    } else {
                        completion(.failure(CustomeError.unknown))
                    }
                    return
                }
                print(data)
                
                let decoder = JSONDecoder()
                
                if let successMessage = try? decoder.decode(T.self, from: data) {
                    completion(.success(successMessage))
                } else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: data) {
                    completion(.failure(CustomeError.networkError(errorMessage.error)))
                } else {
                    let responseString = String(data: data, encoding: .utf8) ?? "none"
                    completion(.failure(CustomeError.decodingError("Error parsing server response: \(responseString)")))
                }
            }.resume()
        }
    }
}
