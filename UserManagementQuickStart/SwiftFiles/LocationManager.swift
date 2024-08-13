//
//  LocationManager.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI
import CoreLocation

@MainActor
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var locationRequested = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        locationRequested = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() // Request a single location update
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationRequested {
            location = locations.first
            locationRequested = false
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find location: \(error.localizedDescription)")
        locationRequested = false
    }
}

