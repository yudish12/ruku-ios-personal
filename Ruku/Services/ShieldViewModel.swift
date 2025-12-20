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
        print("🔹 ========== APPLYING SHIELD ==========")
        print("🔹 Current selection apps count: \(selection.applicationTokens.count)")
        print("🔹 Current selection categories count: \(selection.categoryTokens.count)")
        print("🔹 Max apps allowed: \(maxAppsCount)")

        store.clearAllSettings()
        print("🔹 Cleared previous settings")

        // Clear categories - we only want apps (max 3)
        if !selection.categoryTokens.isEmpty {
            print("🗑️ Clearing categories (only apps allowed)")
            selection.categoryTokens = []
        }

        // Enforce app limit before applying shield
        var apps = selection.applicationTokens
        print("🔹 Apps before limit enforcement: \(apps.count)")
        
        if apps.count > maxAppsCount {
            let tokensArray = Array(apps)
            print("⚠️ App count (\(apps.count)) exceeds limit (\(maxAppsCount))")
            let randomThree = Array(tokensArray.shuffled().prefix(maxAppsCount))
            apps = Set(randomThree)
            selection.applicationTokens = apps
            print("⚠️ Limited to \(maxAppsCount) apps randomly selected")
            print("⚠️ Selected apps: \(apps)")
        } else {
            print("✅ App count (\(apps.count)) is within limit")
        }
        
        print("🔹 Final apps count: \(apps.count)")
        print("🔹 Final categories count: \(selection.categoryTokens.count)")

        if apps.isEmpty {
            print("⚠️ No apps selected to block")
            store.shield.applications = nil
        } else {
            store.shield.applications = apps
            print("✅ Blocking \(apps.count) apps")
            print("✅ Apps being blocked: \(apps)")
        }

        // Always clear categories since we only want apps
        store.shield.applicationCategories = nil
        store.shield.webDomainCategories = nil
        print("✅ Categories cleared (only apps are blocked)")

        print("🔹 ========== SHIELD APPLIED SUCCESSFULLY ==========")
    }

    // MARK: - Remove Shield
    func removeShield() {
        print("🔹 Removing Shield...")
        store.clearAllSettings()
        print("✅ Shield removed")
    }
}

