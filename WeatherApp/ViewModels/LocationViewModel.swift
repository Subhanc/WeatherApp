//
//  LocationViewMoodel.swift
//  WeatherApp
//
//  Created by Subhan Chaudhry on 2022-02-14.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    private var lastSeenCity: String?
    
    private let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
   
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            lastSeenLocation = nil
            lastSeenCity = nil
            return
        }
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
            let city = placemarks?.first?.locality
            
            if city != self.lastSeenCity {
                self.lastSeenCity = city
                self.lastSeenLocation = currentLocation
            }
        }
    }
}
