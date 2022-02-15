//
//  ForcastCellView.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-15.
//

import Foundation
import SwiftUI


struct ForcastCellView: View {
    
    let forcast: Forcast
    
    var body: some View {
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
                    image.frame(width: 15.0, height: 15.0)
                } placeholder: {
                    ProgressView()
                }.padding(.trailing)
            }
            Divider()
        }
    }
}
