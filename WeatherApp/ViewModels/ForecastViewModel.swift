//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI
import CoreLocation

class ForecastViewModel: ObservableObject {
   
    @Published var forecasts: [Forecast] = []
    
    let weatherService: WeatherService
    
    public init(weatherService: WeatherService = OpenWeatherService()) {
        self.weatherService = weatherService
    }
    
    public func load(location: CLLocation?) {
        weatherService.loadWeatherData(location) { (weather, error) in
            guard let weather = weather else {
                return
            }
            DispatchQueue.main.async  {
                self.forecasts = weather.daily.map {
                    Forecast(dailyForecastResponse: $0)
                }
            }
        }
    }
}
