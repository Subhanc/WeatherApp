//
//  Forecast.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation

struct Forecast: Identifiable {
    let id = UUID()
    let date: Date
    let iconUrl: URL
    let minTemperature: Double
    let maxTemperature: Double

    let forecastDetails: ForecastDetails
}

extension Forecast {
    init(dailyForecastResponse: OpenWeatherForecastResponse.Forecast) {
        self.date = Date(timeIntervalSince1970: TimeInterval(dailyForecastResponse.dt))
        self.minTemperature = dailyForecastResponse.temp.min
        self.maxTemperature = dailyForecastResponse.temp.max
        self.iconUrl = URL(string: "https://openweathermap.org/img/wn/\(dailyForecastResponse.weather.first!.icon)@2x.png")!
        self.forecastDetails = ForecastDetails(weather: dailyForecastResponse.weather.first!)
    }
}
