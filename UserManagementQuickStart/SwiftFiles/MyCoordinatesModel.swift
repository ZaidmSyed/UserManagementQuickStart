//
//  MyCoordinatesModel.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/19/24.
//

import Foundation

public struct MyCoordinates: Codable, Equatable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
