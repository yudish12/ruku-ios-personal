//
//  PermissionManager.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

//import Foundation
//import SwiftUI
//import FamilyControls
//import UserNotifications
//import CoreLocation
//import Combine
//
//@MainActor
//class PermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    
//    // MARK: - Published states
//    @Published var isFamilyControlAuthorized: Bool = false
//    @Published var isNotificationAuthorized: Bool = false
//    @Published var isLocationAuthorized: Bool = false
//    @Published var lastError: Error? = nil
//    @Published var shouldShowSettingsAlert: Bool = false
//    
//    // Computed property to check if all permissions are granted
//    var allPermissionsGranted: Bool {
//        isFamilyControlAuthorized && isNotificationAuthorized && isLocationAuthorized
//    }
//
//    
//    // MARK: - Private properties
//    private lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.delegate = self
//        return manager
//    }()
//    
//    // MARK: - Family Controls
//    func requestFamilyControlAuthorization() async {
//        do {
//            let before = AuthorizationCenter.shared.authorizationStatus
//            print("Before request:", before)
//
//            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
//
//            let after = AuthorizationCenter.shared.authorizationStatus
//            print("After request:", after)
//
//            // ✅ TRUST ONLY SYSTEM STATUS
//            isFamilyControlAuthorized = (after == .approved)
//
//            if after != .approved {
//                print("FamilyControls NOT approved — dialog not shown or user denied.")
//            }
//
//        } catch {
//            isFamilyControlAuthorized = false
//            lastError = error
//            print("FamilyControl Authorization error:", error)
//        }
//    }
//
//    
//    // MARK: - Notifications
//    func requestNotificationAuthorization() async  {
//        do {
//            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
//            isNotificationAuthorized = granted
//            shouldShowSettingsAlert = !granted
//        } catch {
//            isNotificationAuthorized = false
//            lastError = error
//            print("Notification Authorization error: \(error)")
//        }
//    }
//    
//    // MARK: - Location
//    func requestLocationAuthorization() {
//        locationManager.requestWhenInUseAuthorization()
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedAlways, .authorizedWhenInUse:
//            isLocationAuthorized = true
//        default:
//            isLocationAuthorized = false
//        }
//    }
//    
//    
//    // MARK: - Method
//    @MainActor
//    func checkAndRequestAllPermissions() async {
//        // --- Family Controls ---
//        let familyStatus = AuthorizationCenter.shared.authorizationStatus
//        if familyStatus != .approved {
//            do {
//                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
//            } catch {
//                lastError = error
//                print("FamilyControls request error: \(error)")
//            }
//        }
//        isFamilyControlAuthorized = (AuthorizationCenter.shared.authorizationStatus == .approved)
//        
//        // --- Notifications ---
//        do {
//            let notificationSettings = await UNUserNotificationCenter.current().notificationSettings()
//            if notificationSettings.authorizationStatus != .authorized {
//                let granted = try await UNUserNotificationCenter.current()
//                    .requestAuthorization(options: [.alert, .badge, .sound])
//                isNotificationAuthorized = granted
//            } else {
//                isNotificationAuthorized = true
//            }
//        } catch {
//            isNotificationAuthorized = false
//            lastError = error
//            print("Notification request error: \(error)")
//        }
//        
//        // --- Location ---
//        let locationStatus = locationManager.authorizationStatus
//        if !(locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse) {
//            locationManager.requestWhenInUseAuthorization()
//        }
//        isLocationAuthorized = (locationManager.authorizationStatus == .authorizedAlways ||
//                                locationManager.authorizationStatus == .authorizedWhenInUse)
//        
//        print("Permissions check complete:")
//        print("FamilyControls: \(isFamilyControlAuthorized)")
//        print("Notifications: \(isNotificationAuthorized)")
//        print("Location: \(isLocationAuthorized)")
//    }
//
//}



import Foundation
import SwiftUI
import FamilyControls
import UserNotifications
import CoreLocation
import Combine

@MainActor
class PermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var isFamilyControlAuthorized: Bool = false
    @Published var isNotificationAuthorized: Bool = false
    @Published var isLocationAuthorized: Bool = false
    @Published var lastError: Error? = nil

    var allPermissionsGranted: Bool {
        isFamilyControlAuthorized && isNotificationAuthorized && isLocationAuthorized
    }

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    // MARK: - Refresh current status without prompting
    func refreshPermissions() async {
        // Family Controls
        try? await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        let familyStatus = AuthorizationCenter.shared.authorizationStatus
        isFamilyControlAuthorized = (familyStatus == .approved)

        // Notifications
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        isNotificationAuthorized = (settings.authorizationStatus == .authorized)

        // Location
        let locationStatus = locationManager.authorizationStatus
        isLocationAuthorized = (locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse)
    }

    // MARK: - Request individual permissions
    func requestFamilyControlAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        } catch {
            lastError = error
        }
        let after = AuthorizationCenter.shared.authorizationStatus
        isFamilyControlAuthorized = (after == .approved)
    }

    func requestNotificationAuthorization() async {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            isNotificationAuthorized = granted
        } catch {
            lastError = error
            isNotificationAuthorized = false
        }
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - CLLocationManagerDelegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        isLocationAuthorized = (status == .authorizedAlways || status == .authorizedWhenInUse)
    }

    // MARK: - Convenience: Check all permissions (passive)
    func checkAllPermissions() async {
        await refreshPermissions()
    }
}


