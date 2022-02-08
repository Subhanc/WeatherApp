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
    
    public func getWeatherData(latitude: Float = 42.984924,
                               longitude: Float = -81.245277,
                               excludes: [Exclude] = [.alerts, .hourly, .minutely, .currentWeather],
                               completion: @escaping (AFResult<Weather>) -> Void) {
       
        print("Fetching data from API")
        
        let excludes: String = excludes.map { $0.rawValue }.joined(separator: ",")
        print(excludes)
        
        let parameters: Parameters = [
            "appid": Service.ACCESS_TOKEN,
            "lat": latitude,
            "lon": longitude,
            "exclude": excludes
            
        ]

        let request = AF.request(Service.API_URL, parameters: parameters)
        
        request.responseData { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    completion(AFResult.success(Weather(data: "yeeee")))
                case .failure(let error):
                        print(error.localizedDescription)
                        completion(AFResult.failure(error))
            }
        }
    }
}

struct Weather {
    var data: String
}

