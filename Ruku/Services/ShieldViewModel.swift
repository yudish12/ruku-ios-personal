//
//  ShieldViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 15/12/25.
//

import Foundation
import SwiftUI
import FamilyControls
import ManagedSettings
import Combine

@MainActor
final class ShieldViewModel: ObservableObject {

    // MARK: - Published State
    @Published var selection = FamilyActivitySelection()

    // Managed Settings Store
    private let store = ManagedSettingsStore()
    
    // Maximum number of apps that can be blocked
    private let maxAppsCount = 3

    // MARK: - Apply Shield
    func applyShield() {
        store.clearAllSettings()
        // Clear categories - we only want apps (max 3)
        if !selection.categoryTokens.isEmpty {
            print("Clearing categories (only apps allowed)")
            selection.categoryTokens = []
        }

        // Enforce app limit before applying shield
        var apps = selection.applicationTokens
        
        if apps.count > maxAppsCount {
            print("App count (\(apps.count)) is not within limit")
            let tokensArray = Array(apps)
            let randomThree = Array(tokensArray.shuffled().prefix(maxAppsCount))
            apps = Set(randomThree)
            selection.applicationTokens = apps
        } else {
            print("App count (\(apps.count)) is within limit")
        }
        

        if apps.isEmpty {
            print("No apps selected to block")
            store.shield.applications = nil
        } else {
            store.shield.applications = apps
            print("Blocking \(apps.count) apps")
            print("Apps being blocked: \(apps)")
        }

        // Always clear categories since we only want apps
        store.shield.applicationCategories = nil
        store.shield.webDomainCategories = nil
        print("Categories cleared (only apps are blocked)")
    }

    // MARK: - Remove Shield
    func removeShield() {
        print("Removing Shield...")
        store.clearAllSettings()
        print("Shield removed")
    }
}

