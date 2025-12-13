//
//  LoginScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI
import Combine

struct LoginScreen: View {
    @EnvironmentObject private var auth: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 150)
                        .padding(.top, 100)
                    
                    TextFieldView(title: "Email", placeholderText: "Enter your Email", text: $auth.loginEmail)
                    
                    PasswordFieldView(password: $auth.loginPassword)
                        .padding(.bottom, 20)
                    
                    
                    NavigationLink(
                        destination: SubscriptionScreen()
                            .environmentObject(auth)
                    ) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .font(.inter(weight: .bold, size: 14))
                            .padding(.vertical, 12)
                            .background(Color.buttonGreenColor)
                            .foregroundStyle(Color.white)
                            .cornerRadius(50)
                    }
                }
                
                NavigationLink(
                    destination: OTPVerificationScreen(email: "yudish@gmail.com")
                        .environmentObject(auth)
                ) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 14))
                        .padding(.vertical, 12)
                        .background(Color.buttonGreenColor)
                        .foregroundStyle(Color.white)
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 100)
            .background(Color.backgroundTealColor)
        }
    }
}


#Preview {
    @Previewable @StateObject var appState = AppStateViewModel()
    @Previewable @StateObject var auth = AuthViewModel()

    LoginScreen()
        .environmentObject(appState)
        .environmentObject(auth)
   
}
