//
//  PasswordFieldView.swift
//  Ruku
//
//  Created by Vishal Singh on 12/12/25.
//

import SwiftUI

struct PasswordFieldView: View {

    @Binding var password: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.inter(weight: .bold, size: 20))
            
            SecureField("Enter your password", text: $password)
                .borderedTextField()
        }
    }
}

//#Preview {
//    PasswordFieldView()
//}
