//
//  ContentView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI
import Adhan

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isLocationUpdated = false // Flag to track if location has been updated
    @State private var updateError: Error? // To store any errors that occur during update

    var body: some View {
        VStack {
            if let location = locationManager.location {
                ProfileView()
                
                if !isLocationUpdated {
                    // Indicate progress or show an error message if necessary
                    if let error = updateError {
                        Text("Failed to update location: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else {
                        Text("Updating location...")
                            .onAppear {
                                Task {
                                    do {
                                        try await SupabaseFunctions.shared.pushCoordinates(coordinates: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                                            isLocationUpdated = true
                                    } catch {
                                        updateError = error
                                    }
                                }
                            }
                    }
                }
            } else {
                Button(action: {
                    locationManager.requestLocation()
                }) {
                    Text("Get Location")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
