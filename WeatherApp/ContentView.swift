//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    let weatherViewModel = WeatherViewModel(weatherService: WeatherService())
    var body: some View {
        NavigationView {
            ScrollView{
                WeatherView(viewModel: weatherViewModel)
            }
            .navigationTitle(Date().getFormattedDate(format: "MMM dd, yyyy") )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
