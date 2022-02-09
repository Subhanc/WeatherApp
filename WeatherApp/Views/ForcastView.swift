//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI

struct ForcastView: View {

    @ObservedObject var viewModel: ForcastViewModel

    var body: some View {
          LazyVStack(alignment: .leading) {
              HStack {
                  Text("7-Day Forcast").font(.title).bold()
                  Spacer()
                  Button("Refresh") {
                      viewModel.load()
                  }.foregroundColor(.blue)
              }
              if self.viewModel.forcasts.isEmpty {
                  Text("No data to show")
              } else {
                  Divider()
                  ForEach(self.viewModel.forcasts) { forcast in
                      NavigationLink(destination: ForcastDetailsView(forcastDetails: forcast.forcastDetails)) {
                          forcastView(forcast: forcast)
                      }
                  }
              }
          }.padding()
         .onAppear(perform: viewModel.load)
      }
    
    
    private func forcastView(forcast: Forcast) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(Date() == forcast.date ? "Today" : forcast.date.dayOfWeek() ?? "Error").font(.title)
                    
                    HStack {
                        Text("Min Temperature: ").bold()
                        Text(String(forcast.minTemperature) + "°C")
                    }
                    HStack {
                        Text("Max Temperature: ").bold()
                        Text(String(forcast.maxTemperature) + "°C")
                    }
                    
                    Text(forcast.date.getFormattedDate(format: "MM-dd-yyyy")).font(.caption)
                }
                Spacer()
                AsyncImage(url: forcast.iconUrl) { image in
                    image.frame(width: 32.0, height: 32.0)
                } placeholder: {
                    ProgressView()
                }.padding(.trailing)
            }
            Divider()
        }
    }
}



