//
//  CreateProfileButton.swift
//  Ruku
//
//  Created by Vishal Singh on 12/12/25.
//

import SwiftUI

struct CreateProfileButton: View {
    @ObservedObject var auth: AuthViewModel
    
    var body: some View {
        NavigationLink(destination: OTPVerificationScreen(email: "yudish@gmail.com")) {
            ZStack {
                if auth.isSubmitting {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.vertical, 12)
                } else {
                    Text("Create Profile")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 14))
                        .padding(.vertical, 12)
                }
            }
            .background(Color.backgroundTealColor)
            .foregroundStyle(Color.white)
            .cornerRadius(50)
        }
        .disabled(!auth.canSubmit)
        .opacity(auth.canSubmit ? 1 : 0.4)
    }
}

#Preview {
    @Previewable @StateObject var auth = AuthViewModel()
    CreateProfileButton(auth: auth)
}
