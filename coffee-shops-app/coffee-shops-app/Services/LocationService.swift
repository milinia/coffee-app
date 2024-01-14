//
//  LocationService.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import CoreLocation

protocol LocationServiceProtocol {
    func distanceFrom(latitude: Double, longitude: Double) -> Int
}

final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        self.userLocation = userLocation
            
        locationManager.stopUpdatingLocation()
    }
    
    func distanceFrom(latitude: Double, longitude: Double) -> Int {
        let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let distance = calculateDistance(from: userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), to: destinationCoordinate)
        return Int(distance / 1000)
    }

    private func calculateDistance(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let sourceLocation = CLLocation(latitude: sourceCoordinate.latitude, longitude: sourceCoordinate.longitude)
        let destinationLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        return sourceLocation.distance(from: destinationLocation)
    }
}
