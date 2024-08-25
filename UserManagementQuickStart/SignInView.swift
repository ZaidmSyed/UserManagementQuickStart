//
//  SignInView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/23/24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistrationPresented = false
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AppTextField(placeHolder: "Email address", text: $email)
            AppSecureField(placeHolder: "Password", text: $password)
            
            Button("New User? Register Here") {
                isRegistrationPresented.toggle()
            }
            .foregroundColor(Color(uiColor: .label))
            .sheet(isPresented: $isRegistrationPresented, content: {
                RegistrationView(appUser: $appUser)
            })
            
            Button {
                Task {
                    do {
                        let appUser = try await signInWithEmail(email: email, password: password)
                        self.appUser = appUser
                    } catch {
                        print("issue with sign in")
                    }
                }
            } label: {
                Text("Sign in")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
            }
        }
        .padding(.horizontal, 24)
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await SupabaseFunctions.shared.signInWithEmail(email: email, password: password)
        } else {
            print("sign in form is invalid")
            throw NSError()
        }
    }
}

#Preview {
    SignInView(appUser: .constant(.init(uid: "1234", email: nil)))
}
