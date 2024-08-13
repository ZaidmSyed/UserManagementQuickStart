//
//  ListingView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import SwiftUI

struct ListingView: View {
    
    @State var arr: [Profile]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LeaderBoardCell(user: arr[0], place: 1)
                    LeaderBoardCell(user: arr[1], place: 2)
//                    LeaderBoardCell(user: arr[2], place: 3)
//                    LeaderBoardCell(user: arr[3], place: 4)
//                    LeaderBoardCell(user: arr[4], place: 5)
                    
                }
            }
        }
    }
}

#Preview {
    ListingView(arr: [])
}
