//
//  AppsViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 16/12/25.
//

import SwiftUI
import Combine


struct AppModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconName: String // system image name or your own icon
}

import SwiftUI
import FamilyControls
import DeviceActivity

@MainActor
class AppsViewModel: ObservableObject {
    @Published var apps: [ManagedApplication] = []
    @Published var blockedApps: Set<String> = []
    
    init() {
        Task {
            if #available(iOS 16.0, *) {
                await loadApps()
                loadBlockedAppsFromLocal()
            }
        }
    }

    @available(iOS 16.0, *)
    func loadApps() async {
        do {
            let applications = try await ManagedSettings.Applications.allApplications()
            apps = applications.sorted { $0.displayName < $1.displayName }
        } catch {
            print("Failed to load apps:", error)
        }
    }
    
    func toggleBlock(app: ManagedApplication) {
        if blockedApps.contains(app.bundleIdentifier) {
            blockedApps.remove(app.bundleIdentifier)
        } else {
            blockedApps.insert(app.bundleIdentifier)
        }
        saveBlockedAppsToLocal()
    }
    
    private let blockedAppsKey = "blockedAppsKey"
    
    func saveBlockedAppsToLocal() {
        UserDefaults.standard.set(Array(blockedApps), forKey: blockedAppsKey)
    }
    
    func loadBlockedAppsFromLocal() {
        if let saved = UserDefaults.standard.array(forKey: blockedAppsKey) as? [String] {
            blockedApps = Set(saved)
        }
    }
    
    func logInfo() {
        print("Total Apps on device: \(apps.count)")
        print("Blocked Apps Count: \(blockedApps.count)")
        print("Blocked Apps Bundle IDs: \(blockedApps)")
    }
}
