//
//  Leaderboards.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import SwiftUI

struct Leaderboards: View {
    
    @State var users: [Profile] = []
    
    var body: some View {
        
                    List(users.indices, id: \.self) { index in
                                LeaderBoardCell(user: users[index], place: index + 1)
                            }
                    .task {
                        do {
                            try await fetchProfiles()
                        } catch {
                            print("Error fetching leaderboard: \(error)")
                        }
                    }
                    .navigationTitle("Leaderboards")
    }
    
    func fetchProfiles() async throws {
        var profiles = try await SupabaseFunctions.shared.fetchProfiles()
        users = sortProfilesByCount(users: profiles)
    }
    
    func sortProfilesByCount(users: [Profile]) -> [Profile] {
            return users.sorted { ($0.count ?? 0) > ($1.count ?? 0) }
    }
}

#Preview {
    Leaderboards()
}
