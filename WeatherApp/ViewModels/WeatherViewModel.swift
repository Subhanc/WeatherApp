//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import UIKit
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var timezone: String = "---"
    @Published var timezoneOffset: Int = 0
    @Published var latitude: Float = 0
    @Published var longitude: Float = 0
    
    @Published var forcasts: [Forcast] = []
    
    public let weatherService: WeatherService

    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func load() {
        weatherService.loadWeatherData { (weather, error) in
            guard let weather = weather else { return }
            DispatchQueue.main.async  {
                self.timezone = weather.timezone
                self.timezoneOffset = weather.timezoneOffset
                self.latitude = weather.lat
                self.longitude = weather.lon
                
                self.forcasts = weather.daily.map {
                    Forcast(dailyForcastResponse: $0)
                }
            }
        }
    }
}


class Forcast: ObservableObject, Identifiable {
    
    @Published var date: Date
    @Published var icon: UIImage
    @Published var minTemperature: Double
    @Published var maxTemperature: Double
    
    init(dailyForcastResponse: WeatherForcastResponse.Forcast) {
        self.date = Date(timeIntervalSince1970: TimeInterval(dailyForcastResponse.dt))
        self.minTemperature = dailyForcastResponse.temp.min
        self.maxTemperature = dailyForcastResponse.temp.max
        
        self.icon = UIImage(fromUrl: "https://openweathermap.org/img/wn/\(dailyForcastResponse.weather.first!.icon)@2x.png")
    }
}
