//
//  LocationCoords.swift
//  WeatherApp
//
//  Created by Luis Martinez on 8/2/25.
//


// MARK: - LocationCoords
struct LocationCoords: Codable {
    let results: [Result]
    let generationtimeMS: Double

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Int
    let featureCode, countryCode: String
    let admin1ID, admin2ID, admin3ID: Int?
    let timezone: String
    let population: Int?
    let postcodes: [String]?
    let countryID: Int
    let country: String
    let admin1, admin2, admin3: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case admin1ID = "admin1_id"
        case admin2ID = "admin2_id"
        case admin3ID = "admin3_id"
        case timezone, population, postcodes
        case countryID = "country_id"
        case country, admin1, admin2, admin3
    }
}
