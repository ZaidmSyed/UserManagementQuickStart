//
//  LeaderBoardCell.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import SwiftUI

struct LeaderBoardCell: View {
    
    var user: Profile
    var place: Int
    
    var body: some View {
        HStack {
            Text("\(place)")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            AsyncImage(url: URL(string: user.avatarURL!)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
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
    }
}

#Preview {
    LeaderBoardCell(user: Profile(username: "Turbo", fullName: "Zaid Syed", website: "hi.com", avatarURL: "005BA427-722A-4D32-88E2-DC9DC8133E3C.jpeg", count: 10), place: 1)
}
