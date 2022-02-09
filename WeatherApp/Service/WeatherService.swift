//
//  Service.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-08.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class WeatherService: NSObject {
        
    public static let ACCESS_TOKEN = "e996f0727652a1fd7ef3261c783e7dc4"
    
    public static let API_URL = "https://api.openweathermap.org/data/2.5/onecall"
    
    private var locationManager: CLLocationManager = CLLocationManager()
    private var location: CLLocation? = nil
    private var completionHandler: ((WeatherForcastResponse?, LocationAuthError?) -> Void)?
    
    public init(locationManager: CLLocationManager) {
        super.init()
        self.locationManager = locationManager
        self.locationManager.delegate = self
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
    
    public func loadWeatherData(_ completionHandler: @escaping((WeatherForcastResponse?, LocationAuthError?) -> Void)) {
        self.fetchSevenDayForcast()
        self.completionHandler = completionHandler
        loadDataOrRequestLocationAuth()
    }

    
    // Long and Lat are place holders until I get CLLocation working.
    public func fetchSevenDayForcast(excludes: [Exclude] = [.alerts, .hourly, .minutely, .currentWeather],
                               unitType: UnitType = .metric) {
               
        let excludes: String = excludes.map { $0.rawValue }.joined(separator: ",")
        
        guard let location = location else {
            print("location is empty")
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
        
        request.responseData { response in
            switch response.result {
                case .success(let data):
                
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(WeatherForcastResponse.self, from: data)
                        self.completionHandler?(response, nil)
                    } catch {
                        print("Error while decoding response \(error.localizedDescription)")
                    }
                case .failure(let error):
                        print(error.localizedDescription)
            }
        }
    }
    
    private func loadDataOrRequestLocationAuth() {
       switch locationManager.authorizationStatus {
           case .authorizedAlways, .authorizedWhenInUse:
             locationManager.startUpdatingLocation()
           case .denied, .restricted:
             completionHandler?(nil, LocationAuthError())
           default:
               completionHandler?(nil, LocationAuthError()) // locationManager.requestWhenInUseAuthorization()
        }
     }
}

extension WeatherService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.location = location
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

public struct LocationAuthError: Error {
    
}
