//
//  ContentView.swift
//  WeatherApp
//
//  Created by Luis Martinez on 7/2/25.
//

import SwiftUI

struct LocationListView: View {
    @State var searchText: String = ""
    
    let locations = ["Alava","Albacete","Alicante","Almería","Asturias","Avila","Badajoz","Barcelona","Burgos","Cáceres",
   "Cádiz","Cantabria","Castellón","Ciudad Real","Córdoba","La Coruña","Cuenca","Gerona","Granada","Guadalajara",
   "Guipúzcoa","Huelva","Huesca","Islas Baleares","Jaén","León","Lérida","Lugo","Madrid","Málaga","Murcia","Navarra",
   "Orense","Palencia","Las Palmas","Pontevedra","La Rioja","Salamanca","Segovia","Sevilla","Soria","Tarragona",
   "Santa Cruz de Tenerife","Teruel","Toledo","Valencia","Valladolid","Vizcaya","Zamora","Zaragoza"]
    
    var searchedLocations: [String] {
        guard !searchText.isEmpty else {
            return locations
        }
        
        return locations.filter({ location in
            location.lowercased().contains(searchText.lowercased())
        })
    }
    
    var body: some View {
        NavigationStack {
            List(searchedLocations, id: \.self) { locationName in
                NavigationLink {
                    LocationClimateInfoView(locationName: locationName)
                } label: {
                    Text(locationName)
                }
                .listRowBackground(Color.blue.opacity(0.1)) // Cell color
            }
            .navigationTitle("Weathear Pro")
            // Top bar color when scrolling
            .toolbarBackground(.blue.opacity(0.3))
            // List background color
            .background(.blue.opacity(0.3))
            .scrollContentBackground(.hidden)
        }
        .searchable(text: $searchText)
        
    }
    
}

#Preview {
    LocationListView()
}
