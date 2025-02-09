//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by Luis Martinez on 9/2/25.
//

import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    @Published var locationName: String = ""
    @Published var locationClimate: LocationClimate?
    
    func fetchWeather(location name: String) async {
        do {
            let (lat, lon, fetchedName) = try await WeatherAPIService.getCoords(name: name)
            let fetchedClimate = try await WeatherAPIService.getTemperatureAt(latitude: lat, longitude: lon)
            
            await MainActor.run {
                locationClimate = fetchedClimate
                locationName = fetchedName
            }
            
        } catch {
            await MainActor.run {
                locationClimate = nil
                locationName = name
            }
            print("Server error: \(error as? WeatherAPIService.APIError)")
        }
    }
}
