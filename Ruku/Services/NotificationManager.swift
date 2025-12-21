//
//  NotificationManager.swift
//  Ruku
//
//  Created by Vishal Singh on 21/12/25.
//

import Foundation
import UserNotifications

enum NotificationType {
    case willStartInFiveMinutes
    case shieldActivated
    case shieldRemoved
}

final class NotificationManager {

    static let shared = NotificationManager()
    
    private init() {}

    // MARK: - Public API
    func scheduleFiveMinutesBeforeSalahTimes(_ salahTime: Date) {
        let triggerDate = Calendar.current.date(byAdding: .minute, value: -5, to: salahTime)
        if let triggerDate {
            let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            self.showNotification(type: .willStartInFiveMinutes, trigger: trigger)
        }
    }

    func scheduleShieldActivated(at date: Date) {
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        showNotification(type: .shieldActivated, trigger: trigger)
    }

    func scheduleShieldRemoved(at date: Date) {
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        showNotification(type: .shieldRemoved, trigger: trigger)
    }

    // MARK: - Core Notification Method
    private func showNotification(
        type: NotificationType,
        trigger: UNNotificationTrigger? = nil
    ) {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "ruku.general"

        switch type {
        case .willStartInFiveMinutes:
            content.title = "Blocking Soon"
            content.body = "App blocking will start in 5 minutes."
        case .shieldActivated:
            content.title = "Shield Active"
            content.body = "Focus shield is now active."
        case .shieldRemoved:
            content.title = "Shield Removed"
            content.body = "Focus shield has been removed."
        }

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}

