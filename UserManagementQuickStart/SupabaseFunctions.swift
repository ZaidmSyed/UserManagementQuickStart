//
//  SupabaseFunctions.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import Foundation
import SwiftUI
import Supabase
import PhotosUI

final class SupabaseFunctions {
    
    static let shared = SupabaseFunctions()
    
    func getInitialProfile() async throws -> Profile {
        do {
          let currentUser = try await supabase.auth.session.user

          let profile: Profile = try await supabase.database
            .from("profiles") // Specifies the table from which to retrieve data.
            .select() // Indicates that you want to select data from the specified table.
            .eq("id", value: currentUser.id) // Adds a filter to the query to match a specific value in the column.
            .single() // Specifies that you expect a single record to be returned.
            .execute() // Executes the query against the database.
            .value // Accesses the actual data from the query response. Used with single()
            
            return profile
            
        } catch {
          debugPrint(error)
            throw error
        }
        
    }
    
    func uploadImage(data: Data, filePath: String) async throws {
        try await supabase.storage
          .from("avatars")
          .upload(
            path: filePath,
            file: data,
            options: FileOptions(contentType: "image/jpeg")
          )
    }
    
    func updateProfileButtonTapped(username: String, fullName: String, website: String, imageURL: String?) async throws {
        let currentUser = try await supabase.auth.session.user

        try await supabase.database
          .from("profiles")
          .update([
            "username": username,
            "full_name": fullName,
            "website": website,
            "avatar_url": imageURL
        ])
          .eq("id", value: currentUser.id)
          .execute()
    }
    
    func downloadImage(path: String) async throws -> AvatarImage {
        let data = try await supabase.storage.from("avatars").download(path: path)
        if let avatarImage = AvatarImage(data: data) {
            return avatarImage
        } else {
            // Handle the case where AvatarImage initialization fails
            throw NSError(domain: "AvatarImageErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create AvatarImage from data"])
        }
    }
    
    
    func getSignedURL(for avatarPath: String) async throws -> URL {
        let expiresIn = 3600 // URL expires in 1 hour
        
        // Generate the signed URL using Supabase storage
        let response = try await supabase.storage
            .from("avatars")
            .createSignedURL(path: avatarPath, expiresIn: expiresIn)
        
        // Extract the signed URL and convert it to a URL object
        let signedURLString = response.absoluteString
        if let signedURL = URL(string: signedURLString) {
            return signedURL
        } else {
            throw URLError(.badURL)
        }
    }

    
    func updateCount(count: Int) async throws {
        let currentUser = try await supabase.auth.session.user
        
        try await supabase.database
          .from("profiles")
          .update([
            "count": count
        ])
          .eq("id", value: currentUser.id)
          .execute()
    }
    
    
    func fetchProfiles() async throws -> [Profile] {
        let response: PostgrestResponse<[Profile]> = try await supabase.database
                    .from("profiles")  // Replace with your table name
                    .select()
                    .execute()
        
        let profiles: [Profile] = try response.value //having issue decoding the data
        return profiles
    }
    
}
