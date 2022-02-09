//
//  WeatherForcastResponse.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation

struct WeatherForcastResponse: Decodable {
    let timezone: String
    let timezoneOffset: Int
    let lat: Float
    let lon: Float
    
    let daily: [Forcast]
    
    struct Forcast: Decodable {
        
        struct Temperature: Decodable {
            let min: Double
            let max: Double
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        struct FeelsLike: Decodable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        struct Weather: Decodable {
            let main: String
            let description: String
            let icon: String
        }
        
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Temperature
        let feelsLike: FeelsLike
        let weather: [Weather]
    }
}
