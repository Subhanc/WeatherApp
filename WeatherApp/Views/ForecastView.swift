//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI
import CoreLocation

struct ForecastView: View {
    
    @StateObject var viewModel: ForecastViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        Group {
            header
            if self.viewModel.forecasts.isEmpty {
                emptyView
            } else {
                content
            }
        }
        .onReceive(locationViewModel.$lastSeenLocation, perform: { newLocation in
            viewModel.load(location: newLocation)
        })
        .id("ForecastView")
    }
    
    private var content: some View {
        ForEach(self.viewModel.forecasts) { forecast in
            NavigationLink(destination: ForecastDetailsView(forecastDetails: forecast.forecastDetails)) {
                ForecastCellView(forecast: forecast)
            }
            .id(forecast.id)
        }
    }
    
    private var header: some View {
        HStack {
            Text("7-Day Forecast").font(.title).bold()
            Spacer()
            Button("Refresh") {
                viewModel.load(location: locationViewModel.lastSeenLocation)
                
            }.foregroundColor(.blue)
        }
        .id("Header")
    }
    
    private var emptyView: some View {
        Text("No data to show")
    }
}



