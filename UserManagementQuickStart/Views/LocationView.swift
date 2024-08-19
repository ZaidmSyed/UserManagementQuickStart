//
//  LocationView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/19/24.
//

import SwiftUI

struct LocationView: View {
    
    @State private var location: MyCoordinates? = UserDefaultsFunctions.shared.getCoordinates()
    
    var body: some View {
        VStack {
            Text("Latitude: \(location?.latitude)")
            Text("Longitude: \(location?.longitude)")
        }
    }
}

#Preview {
    LocationView()
}
