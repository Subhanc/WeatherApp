//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import UIKit
import SwiftUI

class ForcastViewModel: ObservableObject {
    @Published var forcasts: [Forcast] = []
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func load() {
        weatherService.loadWeatherData { (weather, error) in
            guard let weather = weather else { return }
            DispatchQueue.main.async  {
                self.forcasts = weather.daily.map {
                    Forcast(dailyForcastResponse: $0)
                }
            }
        }
    }
}
