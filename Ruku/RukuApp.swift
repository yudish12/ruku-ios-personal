//
//  RukuApp.swift
//  Ruku
//
//  Created by Vishal Singh on 07/12/25.
//

import SwiftUI

@main
struct RukuApp: App {

    @StateObject private var appState = AppStateViewModel()
    @StateObject private var shieldViewModel = ShieldViewModel()
    @StateObject private var permissionManager = PermissionManager()
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true

    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(shieldViewModel)
                .environmentObject(permissionManager)
                
        }
        .onChange(of: scenePhase) { _ , phase in
            if phase == .active && !isFirstLaunch {
                Task {
                    await permissionManager.checkAllPermissions()
                }
            }
        }
    }
}

