//
//  ContentView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                switch locationViewModel.authorizationStatus {
                      case .authorizedAlways, .authorizedWhenInUse:
                          ForcastView(viewModel: ForcastViewModel())
                              .environmentObject(locationViewModel)
                      case .notDetermined:
                          Text("We need your location permission to track you")
                      case .restricted:
                          ErrorView(errorText: "Location use is restricted.")
                      case .denied:
                          ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
                      default:
                          Text("Unexpected status")
                }
            }
            .navigationTitle(Date().formateDate(format: "MMM dd, yyyy") )
            .toolbar {
                Button {
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
        MainView()
    }
}
