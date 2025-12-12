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

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
