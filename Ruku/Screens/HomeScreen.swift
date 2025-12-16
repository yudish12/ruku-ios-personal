//
//  HomeScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var shieldViewModel: ShieldViewModel
    @EnvironmentObject private var appState: AppStateViewModel
    @AppStorage("isBlocked") private var isBlocked: Bool = false


    var body: some View {
        
        NavigationStack {
            ZStack {
                if isBlocked {
                    SalahMode(isBlocked: $isBlocked, shieldViewModel: shieldViewModel)
                        .transition(.opacity) // fade in/out
                } else {
                    content()
                        .transition(.opacity) // fade in/out
                }
            }
            .animation(.easeInOut(duration: 0.5), value: isBlocked) // animate changes
        }
    }
    
    func content() -> some View {
        VStack(spacing: 0) {
            
            // MARK: - Header
            HStack(spacing: 12) {
                // Circle Icon
                Text("A")
                    .font(.inter(weight: .bold, size: 20))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.buttonGreenColor)
                    .clipShape(Circle())
                
                // Welcome Text
                VStack(alignment: .leading, spacing: 2) {
                    Text("Welcome")
                        .font(.inter(weight: .medium, size: 14))
                        .foregroundColor(.white)
                    
                    Text("Abdullah")
                        .font(.inter(weight: .bold, size: 20))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Gear Button
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.backgroundTealColor.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .frame(height: 70)
            .background(Color.backgroundTealColor)
            
            // MARK: - Main Content
            VStack(spacing: 24) {
                Spacer()
                
                Text("Home Screen View")
                    .font(.title2)
                    .foregroundColor(.primary)
                
                Button {
                    appState.authenticateUser(false)
                } label: {
                    Text("Back to Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .clipShape(Capsule())
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // MARK: - Confirm Prayer Button
            Button {
                shieldViewModel.applyShield()
                withAnimation(.easeInOut(duration: 0.5)) {
                       isBlocked = true
                   }
            } label: {
                Text("Confirm Prayer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.backgroundTealColor.opacity(0.9))
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor.ignoresSafeArea())
    }
}

#Preview {
    HomeScreen()
}
