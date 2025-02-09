//
//  ListView.swift
//  WeatherApp
//
//  Created by Luis Martinez on 7/2/25.
//

import SwiftUI

struct ListView: View {

    @StateObject var listVM = ListViewModel()
    
    var body: some View {
        NavigationStack {
            if !listVM.searchedLocations.isEmpty {
                List(listVM.searchedLocations, id: \.self) { locationName in
                    NavigationLink {
                        DetailView(location: locationName)
                    } label: {
                        Text(locationName)
                    }
                    .listRowBackground(Color.blue.opacity(0.1)) // Cell color
                }
                .navigationTitle("Weather Pro Max")
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
                            DetailView(location: listVM.searchText)
                        } label: {
                            Text("Search for \(listVM.searchText) weather")
                                .foregroundStyle(.link)
                                .font(.system(size: 24))
                                .bold()
                        }
                    }
                    .navigationTitle("Weather Pro Max")
                }
            }
        }
        .searchable(text: $listVM.searchText)
        // Top bar color when scrolling
        .toolbarBackground(.blue.opacity(0.3))

    }
    
}

#Preview {
    ListView()
}
