//
//  Converter.swift
//  AstoneWeather
//
//  Created by Софья Норина on 15.10.2023.
//

import Foundation

class Converter {
    
    static let shared = Converter()
    
    func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    func dateToString(day: Int) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        guard let nextDate = calendar.date(byAdding: .day, value: day, to: currentDate) else {
            return ""
        }
        let weekDay = calendar.component(.weekday, from: nextDate)
        dateFormatter.locale = Locale(identifier: "en_US")
        let day = dateFormatter.weekdaySymbols[weekDay - 1]
        return day
        
 }

}
