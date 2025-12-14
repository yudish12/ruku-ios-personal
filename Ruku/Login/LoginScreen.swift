//
//  LoginScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var appState: AppStateViewModel
    @StateObject var authViewModel =  AuthViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text("Create your account")
                            .font(.inter(weight: .bold, size: 30))
                            .foregroundStyle(.white)
                        
                        if let error = authViewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }

                        // Toggle Buttons
                        HStack {
                            SegmentButton(title: "Sign Up", isSelected: authViewModel.mode == .signup) {
                                authViewModel.mode = .signup
                            }
                            
                            SegmentButton(title: "Login", isSelected: authViewModel.mode == .login) {
                                authViewModel.mode = .login
                            }
                        }
                        .padding(2)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        // Form Fields
                        VStack(alignment: .leading, spacing: 16) {
                            
                            if authViewModel.mode == .signup {
                                TextFieldView(title: "Name", placeholderText: "Enter your name", text: $authViewModel.name)
                                
                                GenderSelector(selectedGender: $authViewModel.gender)
                            }
                            
                            TextFieldView(title: "Email", placeholderText: "Enter your email", text: $authViewModel.email)
                            
                            PasswordFieldView(password: $authViewModel.password)
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollDismissesKeyboard(.interactively)
             
                // Action Button
                Button{
                    authViewModel.submit(appState: appState)
                } label: {
                    ZStack {
                          // Keep button size consistent
                          Text(authViewModel.mode == .signup ? "Sign Up" : "Login")
                              .font(.inter(weight: .bold, size: 18))
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                              .padding()
                              .background(Color.buttonGreenColor)
                              .clipShape(Capsule())
                              .opacity(authViewModel.isLoading ? 0 : 1)

                          if authViewModel.isLoading {
                              ProgressView()
                                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                          }
                      }
                }
                .disabled(!authViewModel.canSubmit || authViewModel.isLoading)
            
                PrivacyPolicyRow()
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.backgroundTealColor)
            .navigationDestination(isPresented: $authViewModel.showOTP) {
                OTPVerificationScreen(email: authViewModel.email)
            }
        }
    }
    
}

#Preview {
    LoginScreen()
        .environmentObject(AppStateViewModel())
}
