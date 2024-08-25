//
//  AppTextField.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/23/24.
//

import SwiftUI

struct AppTextField: View {
    var placeHolder: String
    @Binding var text: String
    var body: some View {
        TextField(placeHolder, text: $text)
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
    AppTextField(placeHolder: "Email address", text: .constant(""))
}
