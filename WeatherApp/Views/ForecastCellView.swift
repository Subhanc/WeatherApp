//
//  ForecastCellView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-15.
//

import Foundation
import SwiftUI

struct ForecastCellView: View {
    let forecast: Forecast
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(Date() == forecast.date ? "Today" : forecast.date.dayOfWeek() ?? "Error").font(.title)
                    
                    HStack {
                        Text("Min Temperature: ").bold()
                        Text(String(forecast.minTemperature) + "°C")
                    }
                    HStack {
                        Text("Max Temperature: ").bold()
                        Text(String(forecast.maxTemperature) + "°C")
                    }
                    
                    Text(forecast.date.formateDate(format: "MM-dd-yyyy")).font(.caption)
                }
                Spacer()
                AsyncImage(url: forecast.iconUrl) { image in
                    image.frame(width: 15.0, height: 15.0)
                } placeholder: {
                    ProgressView()
                }.padding(.trailing)
            }
        }
    }
}
