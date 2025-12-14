//
//  SettingsVIew.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {

            // MARK: - Focus
            Section("Focus") {
                NavigationLink {
                    ManageBlockedAppsView()
                } label: {
                    SettingsRow(
                        title: "Manage Blocked Apps",
                        icon: "shield.fill",
                        color: Color.textSecondary
                    )
                }

                NavigationLink {
                    EditSalahTimingsView()
                } label: {
                    SettingsRow(
                        title: "Edit Salah Timings",
                        icon: "clock.fill",
                        color: Color.textSecondary
                    )
                }

                NavigationLink {
                    BypassModeView()
                } label: {
                    SettingsRow(
                        title: "Bypass Mode Settings",
                        icon: "xmark.rectangle.portrait.fill",
                        color: Color.textSecondary
                    )
                }
            }

            // MARK: - Account
            Section("Account") {
                NavigationLink {
                    EditProfileView()
                } label: {
                    SettingsRow(
                        title: "Edit Profile",
                        icon: "person.fill",
                        color: Color.textSecondary
                    )
                }

                NavigationLink {
                    SubscriptionView()
                } label: {
                    SettingsRow(
                        title: "Subscription",
                        icon: "star.circle.fill",
                        color: Color.textSecondary
                    )
                }
            }

            // MARK: - General
            Section("General") {
                NavigationLink {
                    NotificationsView()
                } label: {
                    SettingsRow(
                        title: "Notifications",
                        icon: "bell.fill",
                        color: Color.textSecondary
                    )
                }

                NavigationLink {
                    ThemeView()
                } label: {
                    SettingsRow(
                        title: "Theme",
                        icon: "circle.lefthalf.filled",
                        color: Color.textSecondary
                    )
                }
            }

            // MARK: - Support
            Section("Support") {
                NavigationLink {
                    HelpSupportView()
                } label: {
                    SettingsRow(
                        title: "Help & Support",
                        icon: "questionmark.circle.fill",
                        color: Color.textSecondary
                    )
                }

                NavigationLink {
                    AboutView()
                } label: {
                    SettingsRow(
                        title: "About Ruku",
                        icon: "info.circle.fill",
                        color: Color.textSecondary
                    )
                }
            }
        }
        .background(Color.backgroundColor)
        .navigationTitle("Settings")
    }
}



#Preview {
    SettingsView()
}
