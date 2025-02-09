//
//  LocationCoords.swift
//  WeatherApp
//
//  Created by Luis Martinez on 8/2/25.
//


// MARK: - LocationCoords
struct LocationCoords: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let population: Int?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude
        case population
        case country
    }
}
