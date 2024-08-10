//
//  GameView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/5/24.
//

import SwiftUI
import Supabase

struct GameView: View {
    
    @Binding var count: Int
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 15) {
                Text("\(count)")
                
                HStack {
                    Button {
                        count+=1
                        Task {
                            do {
                                try await addOne()
                            } catch {
                            print("Error updating count: \(error)")
                            }
                        }
                    } label: {
                        Text("+1")
                            .font(.headline)               // Set the font style
                            .foregroundColor(.white)       // Set the text color
                            .padding()                     // Add padding around the text
                            .background(Color.blue)        // Set the background color
                            .cornerRadius(10)              // Round the corners
                            .shadow(radius: 5)
                    }
                        
                        Button {
                            count = 0
                            Task {
                                do {
                                    try await addOne()
                                } catch {
                                print("Error updating count: \(error)")
                                }
                            }
                        } label: {
                            Text("Reset")
                                .font(.headline)               // Set the font style
                                .foregroundColor(.white)       // Set the text color
                                .padding()                     // Add padding around the text
                                .background(Color.blue)        // Set the background color
                                .cornerRadius(10)              // Round the corners
                                .shadow(radius: 5)
                    }
                }
            }
            .padding()
        }
    }
    
    func addOne() async throws {
        try await SupabaseFunctions.shared.updateCount(count: count)
    }
        
}

#Preview {
    GameView(count: .constant(0))
}
