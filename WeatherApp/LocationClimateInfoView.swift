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
            if let locationClimate {
                ZStack {
                    Color.blue.opacity(0.3).ignoresSafeArea()
                    VStack {
                        
                        Text(locationName)
                            .font(.system(size: 70, weight: .bold, design: .serif))
                            .padding(.top, 32)
                        
                        Spacer()
                        
                        Text("\(String(locationClimate.current.temperature2M)) °C")
                            .font(.system(size: 70, weight: .bold, design: .default))
                            .padding(.bottom, 24)
                        
                        Spacer()
                        Text("Apparent Temperature:")
                            .font(.system(size: 24, weight: .bold, design: .default))
                        
                        Text("\(String(locationClimate.current.apparentTemperature)) °C")
                            .font(.system(size: 36, weight: .bold, design: .default))
                        
                        Spacer()
                    }
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
                print("unkown error")
            }
        }
    }
}

#Preview {
    var locationClimate = LocationClimate(
        latitude: 12,
        longitude: 12,
        generationtimeMS: 12,
        utcOffsetSeconds: 12,
        timezone: "",
        timezoneAbbreviation: "",
        elevation: 12,
        currentUnits: CurrentUnits(time: "", interval: "", temperature2M: "", apparentTemperature: ""),
        current: Current(time: "", interval: 1, temperature2M: 12, apparentTemperature: 33)
    )
    LocationClimateInfoView(locationName: "Albacete", locationClimate: locationClimate)
}


