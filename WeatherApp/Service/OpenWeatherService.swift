//
//  Service.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import Alamofire
import CoreLocation

class OpenWeatherService: WeatherService {
        
    let API_URL = "https://api.openweathermap.org/data/2.5"

    let ACCESS_TOKEN = "e996f0727652a1fd7ef3261c783e7dc4"
    
    enum URLPath: String {
        case onecall = "/onecall"
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

    public func loadWeatherData(_ location: CLLocation?,
                                completion: @escaping (OpenWeatherForecastResponse?, WeatherServiceError?) -> Void) {
               
        let excludes: [Exclude] = [.alerts, .hourly, .minutely, .currentWeather]
        let unitType = UnitType.metric
        
        guard let location = location else {
            completion(nil, .locationIsNil)
            return
        }
        
        let parameters: Parameters = [
            "appid": ACCESS_TOKEN,
            "lat": location.coordinate.latitude,
            "lon": location.coordinate.longitude,
            "exclude": excludes.map { $0.rawValue }.joined(separator: ","),
            "units": unitType
        ]

        let request = AF.request(API_URL + URLPath.onecall.rawValue, parameters: parameters)
        
        print("Fetching data")
        request.responseData { response in
            switch response.result {
                case .success(let data):
    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(OpenWeatherForecastResponse.self, from: data)
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
