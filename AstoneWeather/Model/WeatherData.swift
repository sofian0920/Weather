//
//  Model.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation

// MARK: - Weather Data Structures

struct WeatherData: Codable {
    let name: String?
    let coord: Coord
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double?
}


struct Coord: Codable {
    let lon, lat: Double
}


struct Weather: Codable {
    let id: Int
    let main: String
    let icon: String
}




// MARK: - Weekly Weather Data Structures



struct WeekData: Codable {
    let list: [List]
}

struct List: Codable {
    let main: MainClass
    let weather: [WeatherWeek]
}

struct MainClass: Codable {
    let temp: Double?
}

struct WeatherWeek: Codable {
    let id: Int
}
struct WeatherWeekModel {
    var day: String
    var temp: String
}

// MARK: - WeekData Extension

extension WeekData {
    
    var temp1String: String {
        if let temp = list[0].main.temp  {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "Unknown"
        }
    }
    var temp2String: String {
        if let temp = list[7].main.temp  {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "Unknown"
        }
    }
    
    var temp3String: String {
        if let temp = list[14].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "Unknown"
        }
    }
    
    var temp4String: String {
        if let temp = list[21].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "Unknown"
        }
    }
    
    var temp5String: String {
        if let temp = list[28].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "Unknown"
        }
    }

var nextWeekArray: [WeatherWeekModel] {
    return [WeatherWeekModel(day: Converter.shared.dateToString(day: 1), temp: temp1String),
            WeatherWeekModel(day: Converter.shared.dateToString(day: 2), temp: temp2String),
            WeatherWeekModel(day: Converter.shared.dateToString(day: 3), temp: temp3String),
            WeatherWeekModel(day: Converter.shared.dateToString(day: 4), temp: temp4String),
            WeatherWeekModel(day: Converter.shared.dateToString(day: 5), temp: temp5String)]
  }
}


extension WeatherData {
    
    var cityName: String {
        if let cityName = name {
            return cityName
        } else {
            return "Unknown"
        }
    }
    
    var tempratureString: String {
        if let temp = main.temp {
            return "\(String(format: "%.0f", temp))°C"
        } else {
            return "Unknown"
        }
    }
}
