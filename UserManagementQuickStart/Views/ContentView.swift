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
    @State private var isLocationUpdated: Bool = false
    
    var body: some View {
        VStack {
            if isLocationUpdated, let location = locationManager.location {
                ProfileView(location: location)
            } else {
                Button(action: {
                    locationManager.requestLocation()

                        // Update the UserDefaults flag
                        UserDefaults.standard.set(true, forKey: "isLocationUpdated")
                        isLocationUpdated = true
                    
                }) {
                    Text("Get Location")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .onAppear {
            // Fetch the location flag from UserDefaults when the view appears
            // isLocationUpdated = UserDefaults.standard.bool(forKey: "isLocationUpdated")
        }
    }
}

#Preview {
    ContentView()
}

