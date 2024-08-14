//
//  LocationManager.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI
import CoreLocation
//import Adhan

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
//        Task {
//            do {
//                try await pushCoordinates(location: location!)
//            } catch {
//                throw error
//            }
//        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find location: \(error.localizedDescription)")
        locationRequested = false
    }
    
//    func pushCoordinates(location: CLLocation) async throws {
//        let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        try await SupabaseFunctions.shared.pushCoordinates(coordinates: coordinates)
//    }
}

