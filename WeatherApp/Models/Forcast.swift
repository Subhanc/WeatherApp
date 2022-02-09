//
//  Forcast.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation

class Forcast: Identifiable {
    let date: Date
    let iconUrl: URL
    let minTemperature: Double
    let maxTemperature: Double

    let forcastDetails: ForcastDetails
      
    init(dailyForcastResponse: WeatherForcastResponse.Forcast) {
        self.date = Date(timeIntervalSince1970: TimeInterval(dailyForcastResponse.dt))
        self.minTemperature = dailyForcastResponse.temp.min
        self.maxTemperature = dailyForcastResponse.temp.max
        self.iconUrl = URL(string: "https://openweathermap.org/img/wn/\(dailyForcastResponse.weather.first!.icon)@2x.png")!
        self.forcastDetails = ForcastDetails(weather: dailyForcastResponse.weather.first!)
    }
}
