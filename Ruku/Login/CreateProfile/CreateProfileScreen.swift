//
//  CreateProfileScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI
import PhotosUI

struct CreateProfileScreen: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @State private var viewModel = CreateProfileViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(skipAction: appState.completedOrSkipProfile)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AvatarPickerView(image: viewModel.avatarImage) {
                        viewModel.isPickerPresented = true
                    }
                    
                    TextFieldView(placeholderText: "name", text: $viewModel.name)
                 
                    GenderSelector(selectedGender: $viewModel.selectedGender)
                    
                    TextFieldView(placeholderText: "Email", text: $viewModel.email)
                    
                    PasswordFieldView(password: $viewModel.password)

                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 100)
            }
            
            VStack(spacing: 12) {
                Button {
                    Task {
                        try await viewModel.submit()
                        appState.completedOrSkipProfile()
                    }
                } label: {
                    ZStack {
                        Text("Create Profile")
                            .frame(maxWidth: .infinity)
                            .font(.inter(weight: .bold, size: 14))
                            .padding(.vertical, 12)
                            .opacity(viewModel.isSubmitting ? 0 : 1)
                        if viewModel.isSubmitting {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .padding(.vertical, 12)
                        }
                    }
                    .background(Color.primaryColor)
                    .foregroundStyle(Color.white)
                    .cornerRadius(50)
                    .animation(.easeInOut, value: viewModel.isSubmitting)
                }
                .disabled(!viewModel.canSubmit)
                .opacity(viewModel.canSubmit ? 1 : 0.4)
                .animation(.easeInOut, value: viewModel.canSubmit)
                
                HStack(spacing: 4) {
                    Text("By continuing, you agree to our")
                        .font(.inter(weight: .regular, size: 12))
                        .foregroundStyle(Color.primaryColor)
                    
                    Button {
                        // Privacy Policy action
                    } label: {
                        Text("Privacy Policy.")
                            .font(.inter(weight: .bold, size: 12))
                            .foregroundStyle(Color.primaryColor)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .photosPicker(
            isPresented: $viewModel.isPickerPresented,
            selection: $viewModel.selectedPhoto,
            matching: .images)
        .onChange(of: viewModel.selectedPhoto) { oldValue, newValue in
            Task { await viewModel.loadImage(from: newValue) }
        }
    }
}

#Preview {
    
    CreateProfileScreen()
}
