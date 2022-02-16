//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI

struct ForecastDetailsView: View {
    
    let forecastDetails: ForecastDetails
    
    var body: some View {
        VStack {
          Text(forecastDetails.main)
          Text("Description: \(forecastDetails.description)")
          AsyncImage(url: forecastDetails.icon) { image in
                  image.frame(width: 100, height: 100)
              } placeholder: {
                  ProgressView()
            }
        }
    }
}
