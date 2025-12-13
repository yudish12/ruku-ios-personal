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
    @EnvironmentObject private var auth: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AvatarPickerView(image: auth.avatarImage) {
                        auth.isPickerPresented = true
                    }
                    
                    TextFieldView(title: "Name", placeholderText: "Enter your name", text: $auth.name)
                    
                    GenderSelector(selectedGender: $auth.selectedGender)
                    
                    TextFieldView(title: "Email", placeholderText: "Enter your email", text: $auth.email)
                    
                    PasswordFieldView(password: $auth.password)
                    
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 100)
            }
            
            VStack(spacing: 12) {
                CreateProfileButton(auth: auth)
                
                PrivacyPolicyRow()
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .photosPicker(
            isPresented: $auth.isPickerPresented,
            selection: $auth.selectedPhoto,
            matching: .images)
        .onChange(of: auth.selectedPhoto) { oldValue, newValue in
            Task { await auth.loadImage(from: newValue) }
        }
        .navigationTitle("Create your Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Skip") {
                    // do something
                    print("Hello Do you like SwiftUI?")
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var appState = AppStateViewModel()
    @Previewable @StateObject var auth = AuthViewModel()
    
    CreateProfileScreen()
        .environmentObject(appState)
        .environmentObject(auth)
}
