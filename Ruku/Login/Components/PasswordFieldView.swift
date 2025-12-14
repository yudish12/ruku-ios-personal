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
        VStack(alignment: .leading, spacing: 12) {
            Text("Password")
                .font(.inter(weight: .bold, size: 18))
                .foregroundStyle(.white)
            
            SecureField("Enter your password", text: $password)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundColor(Color.backgroundTealColor)
                .padding(.horizontal, 12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))

        }
    }
}

//#Preview {
//    PasswordFieldView()
//}
