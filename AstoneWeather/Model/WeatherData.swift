//
//  Model.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation

struct WeatherData {
    let name: String?
    let coordinat: Coordinate
    let tempAndHum: TemAndHum
    let wind: Wind
    let weather: [Weather]
    let country: Country
    

}


struct Coordinate: Codable {
    let lon, lat: Double
}

struct TemAndHum: Codable {
    let tempreture: Double?
    let humidity: Int?
}

struct Wind: Codable {
    let speed: Double?
}

struct Weather: Codable {
    let id: Int
}

struct Country {
    let country: String?
}

extension WeatherData {
    var cityName: String {
        return name ?? "Unknown"
    }
    var temperaureString: String {
        return String(format: "%.1f", tempAndHum.tempreture ?? 0.0)
    }
    var humidityString: String {
        return "\(tempAndHum.humidity ?? 0) %"
    }
    var windString: String {
        return "\(wind.speed ?? 0)"
    }
    var countryString: String {
        return country.country ?? "Unknown"
    }
    
}


//    
//    var countryString: String {
//        return sys.country ?? "N/A"
//    }
//    
//    func getConditionImageName() -> String {
//        if let condition = weather.first?.id {
//            switch condition {
//            case 200...232:
//                return "thunderImage"
//            case 300...321, 500...531:
//                return "rainSunImage"
//            case 600...622:
//                return "snowImage"
//            case 701...781:
//                return "cloudyImage"
//            case 800:
//                return "sunLittle"
//            case 801...804:
//                return "thunderImage"
//            default:
//                return "cloudyImage"
//            }
//        }
//        return "cloudyImage"
//    }
//    
//    var conditionName: String {
//        return getConditionImageName()
//    }
//}
