//
//  OTPVerificationScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI

struct OTPVerificationScreen: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @StateObject var viewModel: AuthViewModel
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        VStack(spacing: 32) {
            Text("We have sent an OTP to your\nemail: \(viewModel.email)")
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.inter(weight: .regular, size: 14))
                .foregroundColor(.white)
            
            // MARK: - OTP Boxes
            HStack {
                ForEach(0..<viewModel.otp.count, id: \.self) { index in
                    OTPTextField(
                        text: $viewModel.otp[index],
                        isFocused: focusedIndex == index
                    ) { newValue in
                        viewModel.handleInput(newValue, at: index) { newFocus in
                            focusedIndex = newFocus
                        }
                    }
                    .focused($focusedIndex, equals: index)
                }
            }
            
            // MARK: - Verify Button
            
            Button {
                Task {
                    await viewModel.verifyOTP(appState: appState)
                }
            } label: {
                ZStack {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.otp.joined().count == viewModel.otp.count ? Color.buttonGreenColor : Color.buttonGreenColor.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .opacity(viewModel.isLoading ? 0 : 1)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
            }
            .disabled(viewModel.otp.joined().count != viewModel.otp.count || viewModel.isLoading)
            
            // MARK: - Resend OTP
            if !viewModel.canResend {
                Text("Resend OTP in \(viewModel.timeRemaining)s")
                    .font(.inter(weight: .regular, size: 12))
                    .foregroundColor(.white)
                    .onAppear {
                        viewModel.startTimer()
                    }
            } else {
                Button {
                    viewModel.resendOTP()
                } label: {
                    Text("Resend OTP")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 14))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.buttonGreenColor)
                        .clipShape(Capsule())
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Verify Your Account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .background(Color.backgroundTealColor)
        .onAppear {
            viewModel.startTimer()
            focusedIndex = 0
        }
    }
}

#Preview {
    OTPVerificationScreen(viewModel: AuthViewModel())
}

