//
//  CustomeError.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import Foundation

enum CustomeError: Error {
    case invalidURL
    case networkError(String)
    case decodingError(String)
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let errorMessage):
            return "Network error: \(errorMessage)"
        case .decodingError(let errorMessage):
            return "Decoding error: \(errorMessage)"
        case .unknown:
            return "Unknown error"
        }
    }
}
