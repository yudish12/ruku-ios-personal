//
//  NotificationScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct NotificationScreen: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @StateObject private var permissionManager = PermissionManager()
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                
                Text("Stay on Track with\nRUKU")
                    .font(.inter(weight: .bold, size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Text("Enable notifications to receive timely Salah reminders and alerts when distracting apps are opened, helping you maintain focus during prayer.")
                    .font(.inter(weight: .regular, size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
            }
            .padding(.top, 100)
            
            Spacer()
            
            VStack(spacing: 16) {
                Button {
                    Task {
                        await permissionManager.requestNotificationAuthorization()
                        appState.allowOrSkipNotification()
                    }
                } label: {
                    Text("Allow Notifications")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 14))
                        .padding(.vertical, 12)
                        .background(Color.primaryColor)
                        .foregroundStyle(Color.white)
                        .cornerRadius(50)
                }
                
                Button {
                    appState.allowOrSkipNotification()
                } label: {
                    Text("Not Now")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 14))
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.secondaryColor)
                        .cornerRadius(50)
                }
            }
            
        }
        .padding(.horizontal)
        .background(Color.backgroundColor)
    }
}

#Preview {
    NotificationScreen()
}
