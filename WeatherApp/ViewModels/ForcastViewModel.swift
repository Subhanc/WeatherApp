//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import SwiftUI
import CoreLocation

class ForcastViewModel: ObservableObject {
    @Published var forcasts: [Forcast] = []
    
    public let weatherService: WeatherService
    
    public init() {
        self.weatherService = WeatherService()
    }
    
    public func load(locationViewModel: LocationViewModel) {
        weatherService.loadWeatherData(locationViewModel.lastSeenLocation) { (weather, error) in
            guard let weather = weather else {
                return
            }
            DispatchQueue.main.async  {
                self.forcasts = weather.daily.map {
                    Forcast(dailyForcastResponse: $0)
                }
            }
        }
    }
}
