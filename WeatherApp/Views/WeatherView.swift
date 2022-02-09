//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI

struct WeatherView: View {

  @ObservedObject var viewModel: WeatherViewModel

  var body: some View {
      LazyVStack(alignment: .leading) {
          Text("7-Day Forcast").font(.title)
          Divider()
          ForEach(self.viewModel.forcasts) { forcast in
              NavigationLink(destination: ForcastDetailsView()) {
                  forcastView(forcast: forcast)
              }
          }
      }.padding()
    .onAppear(perform: viewModel.load)
  }
    
    
    private func forcastView(forcast: Forcast) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(Date().dayOfWeek() == forcast.date.dayOfWeek() ? "Today" : forcast.date.dayOfWeek() ?? "Error").font(.title)
                    
                    HStack {
                        Text("Min Temperature: ").bold()
                        Text(String(forcast.minTemperature))
                    }
                    HStack {
                        Text("Max Temperature: ").bold()
                        Text(String(forcast.maxTemperature))
                    }
                }
                Spacer()
                
//                Image(uiImage: forcast.icon)
//                        .resizable()
//                        .frame(width: 100, height: 100)
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
//    .alert(isPresented: $viewModel.shouldShowLocationError) {
//      Alert(
//        title: Text("Error"),
//        message: Text("To see the weather, provide location access in Settings."),
//        dismissButton: .default(Text("Open Settings")) {
//          guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
//          UIApplication.shared.open(settingsURL)
//        }
//      )
//    }
//    .onAppear(perform: viewModel.refresh)
//  }
//}



