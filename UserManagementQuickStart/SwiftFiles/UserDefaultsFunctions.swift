//
//  UserDefaultsFunctions.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/19/24.
//

import Foundation

final class UserDefaultsFunctions {
    
    static let shared = UserDefaultsFunctions()
    
    private init() {}
    
    func saveCoordinates(coordinates: MyCoordinates) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(coordinates)
            UserDefaults.standard.set(data, forKey: "savedCoordinates")
        } catch {
            print("Failed to encode coordinates: \(error.localizedDescription)")
        }
    }
    
    func getCoordinates() -> MyCoordinates? {
        if let data = UserDefaults.standard.data(forKey: "savedCoordinates") {
            do {
                let decoder = JSONDecoder()
                let coordinates = try decoder.decode(MyCoordinates.self, from: data)
                return coordinates
            } catch {
                print("Failed to decode coordinates: \(error.localizedDescription)")
            }
        }
        return nil
    }
}
