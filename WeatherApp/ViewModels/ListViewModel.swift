//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Luis Martinez on 9/2/25.
//

import SwiftUI

@MainActor
class ListViewModel: ObservableObject {
    
    @Published var searchText: String = ""

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
    
}
