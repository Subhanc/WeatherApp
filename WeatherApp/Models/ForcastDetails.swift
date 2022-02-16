//
//  ForcastDetails.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation

struct ForcastDetails {
    let main: String
    let description: String
    let icon: URL
}

extension ForcastDetails {
    init(weather: WeatherForcastResponse.Forcast.Weather) {
        self.main = weather.main
        self.description = weather.description
        self.icon = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")!
    }
}
