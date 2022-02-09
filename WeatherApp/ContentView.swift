//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            ScrollView{
                WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
