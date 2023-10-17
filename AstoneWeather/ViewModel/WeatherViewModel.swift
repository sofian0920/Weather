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
    var weatherData: Observable<WeatherData?> { get }
    var nextWeekData: Observable<WeekData?> { get }
    var modelDidChange: (() -> Void)? { get set }
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    
    private let disposeBag = DisposeBag()
    private let _weatherData = BehaviorRelay<WeatherData?>(value: nil)
    private let _nextWeekData = BehaviorRelay<WeekData?>(value: nil)
    
    var modelDidChange: (() -> Void)?
    
    var weatherData: Observable<WeatherData?> {
        return _weatherData.asObservable()
    }
    
    var nextWeekData: Observable<WeekData?> {
        return _nextWeekData.asObservable()
    }
    
    func fetchWeatherData(city: String) {
            NetworkManager.shared.fetchWeatherData(city: city) { [weak self] result in
                switch result {
                case .success(let weatherData):
                    self?._weatherData.accept(weatherData)
                    self?.weatherData = weatherData
                    self?.modelDidChange?()
                case .failure(let error):
                    print("Failed to fetch data:", error)
                }
            }
    }
    
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        NetworkManager.shared.fetchWeatherWithLocation(lat: latitude, lon: longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?._weatherData.accept(weatherData)
                self?.weatherData = weatherData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWeekData(city: String) {
        NetworkManager.shared.fetchWeatherWeekData(city: city) { [weak self] result in
            switch result {
            case .success(let nextWeekData):
                self?._nextWeekData.accept(nextWeekData)
                self?.nextWeekData = nextWeekData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        NetworkManager.shared.fetchWeekWeatherWithLocation(lat: latitude, lon: longitude) { [weak self] result in
            switch result {
            case .success(let nextWeekData):
                self?._nextWeekData.accept(nextWeekData)
                self?.nextWeekData = weatherData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
}
