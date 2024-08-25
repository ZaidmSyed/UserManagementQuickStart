//
//  RegistrationView.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/23/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AppTextField(placeHolder: "Email address", text: $email)
            AppSecureField(placeHolder: "Password", text: $password)
            
            Button {
                Task {
                    do {
                        let appUser = try await registerNewUserWithEmail(email: email, password: password)
                        self.appUser = appUser
                        dismiss.callAsFunction()
                    } catch {
                        print("issue with registration")
                    }
                }
            } label: {
                Text("Register")
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
    
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await SupabaseFunctions.shared.registerNewUserWithEmail(email: email, password: password)
        } else {
            print("registration form is invalid")
            throw NSError()
        }
    }
    
    
}

extension String {
    func isValidEmail() -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }
}

func isFormValid(email: String, password: String) -> Bool {
    guard email.isValidEmail(), password.count > 7 else {
        return false
    }
    return true
}

#Preview {
    RegistrationView(appUser: .constant(.init(uid: "1234", email: nil)))
}
