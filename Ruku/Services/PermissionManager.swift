//
//  PermissionManager.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import Foundation
import SwiftUI
import FamilyControls
import UserNotifications
import CoreLocation
import Combine

@MainActor
class PermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // MARK: - Published states
    @Published var isFamilyControlAuthorized: Bool = false
    @Published var isNotificationAuthorized: Bool = false
    @Published var isLocationAuthorized: Bool = false
    @Published var lastError: Error? = nil
    
    // MARK: - Private properties
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    // MARK: - Family Controls
    func requestFamilyControlAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            isFamilyControlAuthorized = true
        } catch {
            isFamilyControlAuthorized = false
            lastError = error
            print("FamilyControl Authorization error: \(error)")
        }
    }
    
    // MARK: - Notifications
    func requestNotificationAuthorization() async  {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            isNotificationAuthorized = granted
        } catch {
            isNotificationAuthorized = false
            lastError = error
            print("Notification Authorization error: \(error)")
        }
    }
    
    // MARK: - Location
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationAuthorized = true
        default:
            isLocationAuthorized = false
        }
    }
}
