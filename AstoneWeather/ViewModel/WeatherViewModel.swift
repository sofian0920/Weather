//
//  WeatherViewModel.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

protocol WeatherViewModelProtocol {
    var  weatherDataObservable: Observable<WeatherData?> { get }
    var  weekDataObservable: Observable<WeekData?> { get }
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
    func fetchWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees)
    func fetchWeekWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees)
}

class WeatherViewModel {
    
    // MARK: - Properties
    
        private let disposeBag = DisposeBag()
        private let weatherData = BehaviorRelay<WeatherData?>(value: nil)
        private let weekData = BehaviorRelay<WeekData?>(value: nil)
        
    
    // MARK: - Observables
    
        var weatherDataObservable: Observable<WeatherData?> {
            return weatherData.asObservable()
        }
        
        var weekDataObservable: Observable<WeekData?> {
            return weekData.asObservable()
        }
        
    // MARK: - Data Fetching
    
        func fetchWeatherData(city: String) {
            NetworkManager.shared.fetchWeatherData(city: city) { [weak self] result in
                switch result {
                case .success(let weatherData):
                    self?.weatherData.accept(weatherData)
                case .failure(let error):
                    print("Failed to fetch weather data:", error)
                }
            }
        }
        
        func fetchWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) {
            NetworkManager.shared.fetchWeatherWithLocation(lat: lat, lon: lon) { [weak self] result in
                switch result {
                case .success(let weatherData):
                    self?.weatherData.accept(weatherData)
                case .failure(let error):
                    print("Failed to fetch weather data:", error)
                }
            }
        }
        
        func fetchWeatherWeekData(city: String) {
            NetworkManager.shared.fetchWeatherWeekData(city: city) { [weak self] result in
                switch result {
                case .success(let nextWeekData):
                    self?.weekData.accept(nextWeekData)
                case .failure(let error):
                    print("Failed to fetch week weather data:", error)
                }
            }
        }
        
        func fetchWeekWeatherWithLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) {
            NetworkManager.shared.fetchWeekWeatherWithLocation(lat: lat, lon: lon) { [weak self] result in
                switch result {
                case .success(let nextWeekData):
                    self?.weekData.accept(nextWeekData)
                case .failure(let error):
                    print("Failed to fetch week weather data:", error)
                }
            }
        }
    }

