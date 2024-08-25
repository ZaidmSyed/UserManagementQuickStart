//
//  AppSecureField.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/23/24.
//

import SwiftUI

struct AppSecureField: View {
    var placeHolder: String
    @Binding var text: String
    var body: some View {
        SecureField(placeHolder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

#Preview {
    AppSecureField(placeHolder: "Password", text: .constant(""))
}
