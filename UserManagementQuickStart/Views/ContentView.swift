//
//  ContentView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isLocationUpdated: Bool = UserDefaults.standard.bool(forKey: "isLocationUpdated")
    
    var body: some View {
        VStack {
            if isLocationUpdated {
                ProfileView()
            } else {
                VStack {
                    Text("\(isLocationUpdated)")
                    Button(action: {
                        Task {
                            await saveLocationAndProceed()
                        }
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
        .onAppear {
            // Fetch the location flag from UserDefaults when the view appears
            isLocationUpdated = UserDefaults.standard.bool(forKey: "isLocationUpdated")
        }
    }
    
    private func saveLocationAndProceed() async {
        guard let location = locationManager.location else {
            print("Location is not available")
            return
        }
        
        do {
            let coordinates = MyCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            try await UserDefaultsFunctions.shared.saveCoordinates(coordinates: coordinates)
            
            // Update the UserDefaults flag
            UserDefaults.standard.set(true, forKey: "isLocationUpdated")
            isLocationUpdated = true
        } catch {
            print("Failed to save location: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}

