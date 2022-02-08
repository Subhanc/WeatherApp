//
//  Service.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
    
    public static let shared = Service()
    
    public static let ACCESS_TOKEN = "e996f0727652a1fd7ef3261c783e7dc4"
    
    public static let API_URL = "https://api.openweathermap.org/data/2.5/onecall"
    
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
    
    // Long and Lat are place holders until I get CLLocation working.
    public func fetchSevenDayForcast(latitude: Float = -81.245277 ,
                               longitude: Float = 42.984924,
                               excludes: [Exclude] = [.alerts, .hourly, .minutely, .currentWeather],
                               unitType: UnitType = .metric,
                               completion: @escaping (AFResult<WeatherForcastResponse>) -> Void) {
               
        let excludes: String = excludes.map { $0.rawValue }.joined(separator: ",")
        
        print(excludes)
        
        let parameters: Parameters = [
            "appid": Service.ACCESS_TOKEN,
            "lat": latitude,
            "lon": longitude,
            "exclude": excludes,
            "units": unitType
        ]

        let request = AF.request(Service.API_URL, parameters: parameters)
        
        request.responseData { response in
            switch response.result {
                case .success(let data):
                
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let json = JSON(data)
                        print("JSON: \(json)")

                        let response = try decoder.decode(WeatherForcastResponse.self, from: data)
                        
                        completion(AFResult.success(response))
                    } catch {
                        print("Error while decoding response \(error.localizedDescription)")
                    }
                case .failure(let error):
                        print(error.localizedDescription)
                        completion(AFResult.failure(error))
            }
        }
    }
}
