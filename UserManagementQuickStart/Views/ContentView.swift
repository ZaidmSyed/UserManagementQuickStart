//
//  ContentView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.location {
                ProfileView()
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
       // .padding()
    }
}

#Preview {
    ContentView()
}
