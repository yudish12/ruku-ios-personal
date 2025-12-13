//
//  PermissionInfo.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import Foundation

struct PermissionText {
    let title: String
    let description: String
    let icon: String
}

/// All permissions used in the app
enum PermissionInfo {
    static let location = PermissionText(
        title: "Accurate Prayer Times",
        description: "We use your location to calculate precise Salah times for your exact position.",
        icon: "location.circle.fill"
    )
    
    static let notifications = PermissionText(
        title: "Stay Updated on Salah",
        description: "Receive reminders and alerts for upcoming prayer times.",
        icon: "bell.badge.fill"
    )
    
    static let familyControl = PermissionText(
        title: "Block Distracting Apps",
        description: "Allow RUKU to limit selected apps during Salah so you can stay focused.",
        icon: "lock.circle.fill"
    )
}
