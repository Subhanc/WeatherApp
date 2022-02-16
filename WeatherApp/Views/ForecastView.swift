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
            Header()
            if self.viewModel.forcasts.isEmpty {
                EmptyView()
            } else {
                Content()
            }
        }
        .onReceive(locationViewModel.$lastSeenLocation, perform: { newLocation in
            viewModel.load(location: newLocation)
        })
        .id("ForecastView")
    }
    
    private func Content() -> some View {
        ForEach(self.viewModel.forcasts) { forcast in
            NavigationLink(destination: ForcastDetailsView(forcastDetails: forcast.forcastDetails)) {
                ForcastCellView(forcast: forcast)
            }
            .id(forcast.id)
        }
    }
    
    private func Header() -> some View {
        HStack {
            Text("7-Day Forcast").font(.title).bold()
            Spacer()
            Button("Refresh") {
                viewModel.load(location: locationViewModel.lastSeenLocation)
                
            }.foregroundColor(.blue)
        }
        .id("Header")
    }
    
    private func EmptyView() -> some View {
        Text("No data to show")
    }
}



