//
//  ContentView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State var isLocationUpdated: Bool = false

    var body: some View {
        VStack {
            if isLocationUpdated {
                let location = locationManager.location
                ProfileView(location: locationManager.location!)
            } else {
                Button(action: {
                    locationManager.requestLocation()
                    Task {
                        try await SupabaseFunctions.shared.switchLocationFlag()
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
        .task {
                    // Fetch the location flag asynchronously when the view appears
                    do {
                        self.isLocationUpdated = try await SupabaseFunctions.shared.fetchLocationFlag()
////                        if !isLocationUpdated {
////                            locationManager.requestLocation()
////                        }
                    } catch {
                        print("Failed to fetch location flag: \(error.localizedDescription)")
                    }
                }
    }
}

#Preview {
    ContentView()
}
