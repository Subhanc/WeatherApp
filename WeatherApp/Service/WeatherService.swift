//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-15.
//

import Foundation
import CoreLocation

protocol WeatherService {
    var API_URL: String { get }
    var ACCESS_TOKEN: String { get }
    
    func loadWeatherData(_ location: CLLocation?,
                         completion: @escaping((WeatherForcastResponse?, WeatherServiceError?) -> Void))
}

enum WeatherServiceError: Error {
    case locationIsNil
    case failToDecodeResponse
    case httpRequestError
}
