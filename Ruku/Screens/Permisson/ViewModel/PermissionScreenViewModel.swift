//
//  PermissionScreenViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import SwiftUI
import Combine

@MainActor
class PermissionScreenViewModel: ObservableObject {
    @Published var permissionManager = PermissionManager()
    
    var allPermissionsGranted: Bool {
        permissionManager.isLocationAuthorized &&
        permissionManager.isNotificationAuthorized &&
        permissionManager.isFamilyControlAuthorized
    }
    
    func allowLocation() {
        permissionManager.requestLocationAuthorization()
    }
    
    func allowNotifications() async {
        await permissionManager.requestNotificationAuthorization()
    }
    
    func allowFamilyControls() async {
        await permissionManager.requestFamilyControlAuthorization()
    }
}
