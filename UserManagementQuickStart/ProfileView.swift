//
//  ProfileView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/4/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var username = ""
    @State var fullName = ""
    @State var website = ""
    @State var count: Int = 0
    
    @State var isLoading = false
    
    @State var imageSelection: PhotosPickerItem?
    @State var avatarImage: AvatarImage?
    
    @State var users: [Profile] = []
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    HStack {
                        Group {
                            if let avatarImage {
                                avatarImage.image.resizable()
                            } else {
                                Color.clear
                            }
                        }
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        
                        Spacer()
                        
                        PhotosPicker(selection: $imageSelection, matching: .images) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                
                Section {
                    TextField("Username", text: $username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                    TextField("Full name", text: $fullName)
                        .textContentType(.name)
                    TextField("Website", text: $website)
                        .textContentType(.URL)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    Button("Update profile") {
                        updateProfileButtonTapped()
                    }
                    .bold()
                    
                    if isLoading {
                        ProgressView()
                    }
                }
                
                NavigationLink(destination: GameView(count: $count)) {
                    Text("Go to Game View")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: Leaderboards(users: users)) {
                    Text("Go to Leaderboards")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Profile")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading){
                    Button("Sign out", role: .destructive) {
                        Task {
                            try? await supabase.auth.signOut()
                        }
                    }
                }
            })
            .onChange(of: imageSelection) { _, newValue in
                guard let newValue else { return }
                loadTransferable(from: newValue)
            }
        }
        .task {
            await getInitialProfile()
        }
    }
    
    //abstracted
    func getInitialProfile() async {
        do {
            
            let profile: Profile = try await SupabaseFunctions.shared.getInitialProfile()
            
            self.username = profile.username ?? ""
            self.fullName = profile.fullName ?? ""
            self.website = profile.website ?? ""
            self.count = profile.count ?? 0
            
            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
                try await downloadImage(path: avatarURL)
            }
            
            try await fetchProfiles()
            
        } catch {
            debugPrint(error)
        }
    }
    
    //abstracted
    func updateProfileButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                
                let imageURL = try await uploadImage()
                
                try await SupabaseFunctions.shared.updateProfileButtonTapped(username: username, fullName: fullName, website: website, imageURL: imageURL)
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func fetchProfiles() async throws {
        var profiles = try await SupabaseFunctions.shared.fetchProfiles()
        users = sortProfilesByCount(users: profiles)
    }
    
    func sortProfilesByCount(users: [Profile]) -> [Profile] {
        return users.sorted { ($0.count ?? 0) > ($1.count ?? 0) }
    }
    
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) {
        Task {
            do {
                avatarImage = try await imageSelection.loadTransferable(type: AvatarImage.self)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    //abstracted
    private func downloadImage(path: String) async throws {
        avatarImage = try await SupabaseFunctions.shared.downloadImage(path: path)
    }
    
    //abstracted
    private func uploadImage() async throws -> String? {
        guard let data = avatarImage?.data else { return nil }
        
        let filePath = "\(UUID().uuidString).jpeg"
        
        try await SupabaseFunctions.shared.uploadImage(data: data, filePath: filePath)
        
        return filePath
    }
    
}
