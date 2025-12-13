//
//  PermissionScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct PermissionScreen: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @StateObject private var permissionManager = PermissionManager()
    
    var body: some View {
       
        VStack(spacing: 12) {
            ScrollView {
                Text("Let's Get You Set Up")
                    .font(.inter(weight: .bold, size: 30))
                    .foregroundStyle(.white)
                
                Text("RUKU needs your permission to provide accurate prayer times and help you stay focused.")
                    .font(.inter(weight: .medium, size: 16))
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .lineSpacing(5)
                    .multilineTextAlignment(.center)
                
                
                SinglePermissonRow(
                    title: PermissionInfo.location.title,
                    icon: PermissionInfo.location.icon,
                    desctiption: PermissionInfo.location.description,
                    isGranted: $permissionManager.isLocationAuthorized
                ) {
                    permissionManager.requestLocationAuthorization()
                }
                
                SinglePermissonRow(
                    title: PermissionInfo.notifications.title,
                    icon: PermissionInfo.notifications.icon,
                    desctiption: PermissionInfo.notifications.description,
                    isGranted: $permissionManager.isNotificationAuthorized

                ) {
                    Task { await permissionManager.requestNotificationAuthorization() }
                }
                .padding(.vertical, 8)
                
                SinglePermissonRow(
                    title: PermissionInfo.familyControl.title,
                    icon: PermissionInfo.familyControl.icon,
                    desctiption: PermissionInfo.familyControl.description,
                    isGranted: $permissionManager.isFamilyControlAuthorized

                ) {
                    Task { await permissionManager.requestFamilyControlAuthorization() }
                }
                
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Button {
                appState.allowPermission()
            } label: {
                Text("Continue to RUKU")
                    .font(.inter(weight: .bold, size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.buttonGreenColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            PrivacyPolicyRow()
                .padding(.top, 8)
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundTealColor)
    }
}


#Preview {
    @Previewable var appState = AppStateViewModel()
    PermissionScreen()
        .environmentObject(appState)
}
