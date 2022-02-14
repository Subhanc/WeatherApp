//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                switch locationViewModel.authorizationStatus {
                      case .notDetermined:
                          Text("We need your location permission to track you")
                      case .restricted:
                          ErrorView(errorText: "Location use is restricted.")
                      case .denied:
                          ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
                      case .authorizedAlways, .authorizedWhenInUse:
                            ForcastView(viewModel: ForcastViewModel())
                                .environmentObject(locationViewModel)
                      default:
                          Text("Unexpected status")
                }
            }
            .navigationTitle(Date().getFormattedDate(format: "MMM dd, yyyy") )
            .toolbar {
                Button {
                    print("requesting location")
                    locationViewModel.requestPermission()
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
