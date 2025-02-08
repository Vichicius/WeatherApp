//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Luis Martinez on 8/2/25.
//

import Foundation
import SwiftUI

struct APIEndpoints {
    /// https://open-meteo.com/en/docs

    /// Base URLs
    private static let weatherBaseURL = "https://api.open-meteo.com/v1/forecast"
    private static let geocodingBaseURL = "https://geocoding-api.open-meteo.com/v1/search"

    /// Temperature Endpoint
    static func temperature(latitude: String, longitude: String) -> String {
        var components = URLComponents(string: weatherBaseURL)!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature")
        ]
        return components.url!.absoluteString
    }

    /// Location Coordinates Endpoint
    static func location(name: String) -> String {
        var components = URLComponents(string: geocodingBaseURL)!
        components.queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ]
        return components.url!.absoluteString
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class WeatherAPIManager {
    static func getCoords(name: String) async throws -> (lat: String, lon: String) {
        guard let url = URL(string: APIEndpoints.location(name: name)) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let data = try JSONDecoder().decode(LocationCoords.self, from: data)
            guard let location = data.results.sorted(by: {$0.population > $1.population}).first else {
                throw APIError.invalidData
            }
            print("Most populated location with that name: \(location.name)")
            print("lat: \(location.latitude), lon: \(location.longitude)")
            return ("\(location.latitude)", "\(location.longitude)")
        } catch {
            throw APIError.invalidData
        }
    }
    
    static func getTemperatureAt(latitude: String, longitude: String) async throws -> LocationClimate {
        guard let url = URL(string: APIEndpoints.temperature(latitude: latitude, longitude: longitude)) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let data = try JSONDecoder().decode(LocationClimate.self, from: data)
            print("Temperature at 2m above ground: \(data.current.temperature2M)")
            return data
        } catch {
            throw APIError.invalidData
        }
    }
}

