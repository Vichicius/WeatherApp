//
//  DetailView.swift
//  WeatherApp
//
//  Created by Luis Martinez on 7/2/25.
//

import Foundation
import SwiftUI


struct DetailView: View {
    @StateObject var detailVM = DetailViewModel()
    
    var location: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()
                
                VStack {
                    
                    Text(detailVM.locationName)
                        .font(.system(size: 70, weight: .bold, design: .serif))
                        .padding(.top, 32)
                    
                    Spacer()
                    
                    if let locationClimate = detailVM.locationClimate {
                        
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
            await detailVM.fetchWeather(location: location)
        }
    }
}

#Preview {
    DetailView(location: "Madrid")
}


