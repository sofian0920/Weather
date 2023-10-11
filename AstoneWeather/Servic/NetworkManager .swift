//
//  NetworkManager .swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation
import CoreLocation


class NetworkManager {
    let weathDayUrl = "https://api.openweathermap.org/data/2.5/weather?appid=91e5d58992af1530198417d1084df956&&units=metric"
    
    static let shared = NetworkManager()
    
    func fetchWeatherData(city: String, complition: @escaping (Result<WeatherData, Error>) -> Void) {
        let url = "\(weathDayUrl)&q=\(city)"
    }
    
    func sendRequest<T:Codable>(with url: String, decodType: T.Type, completion: @escaping (Result<T, Error>) -> Void){
        guard let url = URL(string: url) else {
            completion(.failure(CustomeError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
