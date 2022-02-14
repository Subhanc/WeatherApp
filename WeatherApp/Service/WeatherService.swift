//
//  Service.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherService: NSObject {
        
    public static let ACCESS_TOKEN = "e996f0727652a1fd7ef3261c783e7dc4"
    
    public static let API_URL = "https://api.openweathermap.org/data/2.5/onecall"

    enum LocationAuthError: Error {
        case locationIsNil
        case failToDecodeResponse
        case httpRequestError
    }
        
    enum Exclude: String {
        case currentWeather = "current"
        case minutely = "minutely"
        case hourly = "hourly"
        case daily = "daily"
        case alerts = "alerts"
    }
    
    enum UnitType: String {
        case metric = "metric"
    }
    
    public func loadWeatherData(_ location: CLLocation?, excludes: [Exclude] = [.alerts, .hourly, .minutely, .currentWeather],
                                     unitType: UnitType = .metric, completion: @escaping((WeatherForcastResponse?, LocationAuthError?) -> Void)) {
               
        let excludes: String = excludes.map { $0.rawValue }.joined(separator: ",")
        
        guard let location = location else {
            completion(nil, .locationIsNil)
            return
        }
        
        let parameters: Parameters = [
            "appid": WeatherService.ACCESS_TOKEN,
            "lat": location.coordinate.latitude,
            "lon": location.coordinate.longitude,
            "exclude": excludes,
            "units": unitType
        ]

        let request = AF.request(WeatherService.API_URL, parameters: parameters)
        
        print("fetching data")
        request.responseData { response in
            switch response.result {
                case .success(let data):
                
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(WeatherForcastResponse.self, from: data)
                        completion(response, nil)
                    } catch {
                        print("Error while decoding response \(error.localizedDescription)")
                        completion(nil, .failToDecodeResponse)
                    }
                case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil, .httpRequestError)

            }
        }
    }
}
