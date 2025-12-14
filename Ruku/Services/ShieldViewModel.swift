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

    // MARK: - Apply Shield
    func applyShield() {
        print("🔹 Applying Shield...")
        print("Current selection apps: \(selection.applicationTokens)")
        print("Current selection categories: \(selection.categoryTokens)")

        store.clearAllSettings()
        print("🔹 Cleared previous settings")

        let apps = selection.applicationTokens
        let categories = selection.categoryTokens

        if apps.isEmpty {
            print("⚠️ No apps selected to block")
            store.shield.applications = nil
        } else {
            store.shield.applications = apps
            print("✅ Blocking apps: \(apps)")
        }

        if categories.isEmpty {
            store.shield.applicationCategories = nil
            store.shield.webDomainCategories = nil
            print("⚠️ No categories selected to block")
        } else {
            store.shield.applicationCategories = .specific(categories)
            store.shield.webDomainCategories = .specific(categories)
            print("✅ Blocking categories: \(categories)")
        }

        print("🔹 Shield applied successfully")
    }

    // MARK: - Remove Shield
    func removeShield() {
        print("🔹 Removing Shield...")
        store.clearAllSettings()
        print("✅ Shield removed")
    }
}

