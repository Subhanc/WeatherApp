//
//  WeatherServiceError.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-15.
//

import Foundation

enum WeatherServiceError: Error {
    case locationIsNil
    case failToDecodeResponse
    case httpRequestError
}
