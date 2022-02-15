//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI
import CoreLocation

struct ForcastView: View {

    @ObservedObject var viewModel: ForcastViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
          VStack(alignment: .leading) {
              Header()
             if self.viewModel.forcasts.isEmpty {
                  EmptyView()
              } else {
                  Content()
              }
          }
        .padding()
        .onAppear { viewModel.load(locationViewModel: locationViewModel) }
    }
    
    private func Content() -> some View {
        ForEach(self.viewModel.forcasts) { forcast in
            NavigationLink(destination: ForcastDetailsView(forcastDetails: forcast.forcastDetails)) {
                ForcastCellView(forcast: forcast)
            }
        }
    }
    
    private func Header() -> some View {
        HStack {
            Text("7-Day Forcast").font(.title).bold()
            Spacer()
            Button("Refresh") {
                viewModel.load(locationViewModel: locationViewModel)
                
            }.foregroundColor(.blue)
        }
    }
    
    private func EmptyView() -> some View {
        Text("No data to show")
    }
}



