//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    private var locationManager = CLLocationManager()
    var body: some View {
        NavigationView {
            ScrollView{
                ForcastView(viewModel: ForcastViewModel(weatherService: WeatherService(locationManager: locationManager)))
            }
            .navigationTitle(Date().getFormattedDate(format: "MMM dd, yyyy") )
            .toolbar {
                Button {
                    print("requesting location")
                    locationManager.requestWhenInUseAuthorization()
                } label: {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                        .frame(width: 32, height: 32)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
