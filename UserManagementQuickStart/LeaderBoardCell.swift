//
//  LeaderBoardCell.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import SwiftUI
import Kingfisher

struct LeaderBoardCell: View {
    
    var user: Profile
    var place: Int
    //    @State var avatarImage: AvatarImage?
    @State private var avatarURL: URL? = nil
    
    
    var body: some View {
        HStack {
            Text("\(place)")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            //            if let avatarImage {
            //              avatarImage.image
            //                    .resizable()
            //                    .frame(width: 40, height: 40)
            //                    .clipShape(Circle())
            //            } else {
            //                Image(systemName: "person.fill")
            //                    .resizable()
            //                    .frame(width: 40, height: 40)
            //                    .clipShape(Circle())
            //            }
            
            if let avatarURL = avatarURL {
                KFImage(URL(string: avatarURL.absoluteString))
                    .resizable()
                    .placeholder {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text("\(user.fullName ?? "none")")
                    .font(.headline)
                Text("\(user.username ?? "none")")
            }
            
            Spacer()
            
            Text("\(user.count ?? 0)")
        }
        .frame(width: 350)
        .padding(8)
        .background(Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
        //      .shadow(color: .yellow, radius: 10)
        .onAppear {
            //                    Task {
            //                        if let avatarURL = user.avatarURL, !avatarURL.isEmpty {
            //                            do {
            //                                try await downloadImage(path: avatarURL)
            //                            } catch {
            //                                print("Error downloading image: \(error)")
            //                            }
            //                        }
            //                    }
            
            loadAvatarURL()
        }
    }
    
    //    private func downloadImage(path: String) async throws {
    //        avatarImage = try await SupabaseFunctions.shared.downloadImage(path: path)
    //      }
    
    private func loadAvatarURL() {
        if let avatarPath = user.avatarURL, !avatarPath.isEmpty {
            Task {
                do {
                    let url = try await SupabaseFunctions.shared.getSignedURL(for: avatarPath)
                    self.avatarURL = url
                } catch {
                    print("Error generating signed URL: \(error)")
                }
            }
        }
    } // end of func
}

#Preview {
    LeaderBoardCell(user: Profile(username: "Turbo", fullName: "Zaid Syed", website: "hi.com", avatarURL: "005BA427-722A-4D32-88E2-DC9DC8133E3C.jpeg", count: 10), place: 1)
}
