//
//  LocationClimateInfoView.swift
//  WeatherApp
//
//  Created by Luis Martinez on 7/2/25.
//

import Foundation
import SwiftUI


struct LocationClimateInfoView: View {
    @State var locationName: String
    @State var locationClimate: LocationClimate?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()
                if let locationClimate {
                    VStack {
                        Text("Temperature: \(String(locationClimate.current.temperature2M))")
                        Text("Apparent Temperature: \(String(locationClimate.current.apparentTemperature))")
                    }
                }
            }
            .task {
                do {
                    let locationCoords = try await WeatherAPIManager.getCoords(name: locationName)
                    locationName = locationCoords.name
                    locationClimate = try await WeatherAPIManager.getTemperatureAt(latitude: locationCoords.lat, longitude: locationCoords.lon)
                } catch APIError.invalidData {
                    print("invalid data")
                } catch APIError.invalidURL {
                    print("invalid url")
                } catch APIError.invalidResponse {
                    print("invalid response")
                } catch {
                    print("invalid")
                }
            }
            .navigationTitle(locationName)
        }
    }
}

#Preview {
    LocationClimateInfoView(locationName: "Albacete")
}
