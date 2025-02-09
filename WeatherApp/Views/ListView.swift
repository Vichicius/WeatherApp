//
//  ListView.swift
//  WeatherApp
//
//  Created by Luis Martinez on 7/2/25.
//

import SwiftUI

struct ListView: View {
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
            if !searchedLocations.isEmpty {
                List(searchedLocations, id: \.self) { locationName in
                    NavigationLink {
                        DetailView(location: locationName)
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
            } else {
                ZStack {
                    Color.blue.ignoresSafeArea().opacity(0.3)
                    VStack {
                        NavigationLink {
                            DetailView(location: searchText)
                        } label: {
                            Text("Search for \(searchText) weather")
                                .foregroundStyle(.link)
                                .font(.system(size: 24))
                                .bold()
                        }
                    }
                    .navigationTitle("Weathear Pro")
                }
            }
        }
        .searchable(text: $searchText)
        // Top bar color when scrolling
        .toolbarBackground(.blue.opacity(0.3))

    }
    
}

#Preview {
    ListView()
}
