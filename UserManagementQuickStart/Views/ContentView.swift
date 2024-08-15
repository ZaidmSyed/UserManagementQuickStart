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
                let location = locationManager.location
                ProfileView(location: locationManager.location!)
            } else {
                Button(action: {
                    locationManager.requestLocation()
                    Task {
                        // Update the UserDefaults flag instead of calling Supabase function
                        UserDefaults.standard.set(true, forKey: "isLocationUpdated")
                        isLocationUpdated = true
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
        .onAppear {
            // Fetch the location flag from UserDefaults when the view appears
            isLocationUpdated = UserDefaults.standard.bool(forKey: "isLocationUpdated")
        }
    }
}

#Preview {
    ContentView()
}
