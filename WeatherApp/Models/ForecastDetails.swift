//
//  ForecastDetails.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation

struct ForecastDetails {
    let main: String
    let description: String
    let icon: URL
}

extension ForecastDetails {
    init(weather: OpenWeatherForecastResponse.Forecast.Weather) {
        self.main = weather.main
        self.description = weather.description
        self.icon = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")!
    }
}
