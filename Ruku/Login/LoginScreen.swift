//
//  LoginScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 150)
                        .padding(.top, 100)
                    
                    TextFieldView(placeholderText: "Email", text: $email)
                    
                    PasswordFieldView(password: $password)
                        .padding(.bottom, 20)
                   
                    
                    NavigationLink(destination: SubscriptionScreen())
                    {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .font(.inter(weight: .bold, size: 14))
                            .padding(.vertical, 12)
                            .background(Color.primaryColor)
                            .foregroundStyle(Color.white)
                            .cornerRadius(50)
                    }
                    
                    NavigationLink(destination: CreateProfileScreen()) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .font(.inter(weight: .bold, size: 14))
                            .padding(.vertical, 12)
                            .background(Color.primaryColor)
                            .foregroundStyle(Color.white)
                            .cornerRadius(50)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    LoginScreen()
}
