//
//  SettingsVIew.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.backgroundTealColor
                .ignoresSafeArea()

            List {
                // MARK: - Focus
                Section {
                    NavigationLink {
                        ManageBlockedAppsView()
                    } label: {
                        SettingsRow(
                            title: "Manage Blocked Apps",
                            icon: "shield.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }

                    NavigationLink {
                        EditSalahTimingsView()
                    } label: {
                        SettingsRow(
                            title: "Edit Salah Timings",
                            icon: "clock.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }

                    NavigationLink {
                        BypassModeView()
                    } label: {
                        SettingsRow(
                            title: "Bypass Mode Settings",
                            icon: "xmark.rectangle.portrait.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }
                    
                    
                } header: {
                    Text("FOCUS")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top, 16)
                }

                // MARK: - Account
                Section {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        SettingsRow(
                            title: "Edit Profile",
                            icon: "person.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }

                    NavigationLink {
                        SubscriptionView()
                    } label: {
                        SettingsRow(
                            title: "Subscription",
                            icon: "star.circle.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }
                } header: {
                    Text("ACCOUNT")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top, 16)
                }

                // MARK: - General
//                Section {
//                    NavigationLink {
//                        NotificationsView()
//                    } label: {
//                        SettingsRow(
//                            title: "Notifications",
//                            icon: "bell.fill",
//                            color: Color.textSecondary
//                        )
//                    }
//
//                    NavigationLink {
//                        ThemeView()
//                    } label: {
//                        SettingsRow(
//                            title: "Theme",
//                            icon: "circle.lefthalf.filled",
//                            color: Color.textSecondary
//                        )
//                    }
//                } header: {
//                    Text("GENERAL")
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .padding(.top, 16)
//                }

                // MARK: - Support
                Section {
                    NavigationLink {
                        HelpSupportView()
                    } label: {
                        SettingsRow(
                            title: "Help & Support",
                            icon: "questionmark.circle.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                        )
                    }

                    NavigationLink {
                        AboutView()
                    } label: {
                        SettingsRow(
                            title: "About Ruku",
                            icon: "info.circle.fill",
                            color: Color.textSecondary,
                            iconColor: Color.backgroundTeal
                            
                        )
                    }
                } header: {
                    Text("SUPPORT")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top, 16)
                }
            }
            .cornerRadius(8)
            .scrollContentBackground(.hidden) // ✅ KEY LINE
            .listStyle(.insetGrouped)         // optional (recommended)
        }
        .navigationTitle("Settings")
        .toolbarColorScheme(.dark, for: .navigationBar)
        
    }
}


#Preview {
    SettingsView()
}
