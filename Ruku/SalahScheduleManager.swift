//
//  SalahScheduleManager.swift
//  Ruku
//
//  Created by yudish on 20/12/25.
//
import DeviceActivity
import Foundation

extension DeviceActivityName {
    static let salah = DeviceActivityName("salah_block")
}

final class SalahScheduleManager {
    static let shared = SalahScheduleManager()
    private let center = DeviceActivityCenter()

    func scheduleSalah(
        activity: DeviceActivityName,
        hour: Int,
        minute: Int,
        durationMinutes: Int = 20
    ) {
        let start = DateComponents(hour: hour, minute: minute)

        let total = minute + durationMinutes
        let end = DateComponents(
            hour: hour + total / 60,
            minute: total % 60
        )

        let schedule = DeviceActivitySchedule(
            intervalStart: start,
            intervalEnd: end,
            repeats: true
        )
        
        // Schedule notifications so they fire even if the app is locked or killed
        let startDate = dateForToday(hour: hour, minute: minute)
        let endDate = Calendar.current.date(byAdding: .minute, value: durationMinutes, to: startDate) ?? startDate

        // a) Five minutes before
        NotificationManager.shared.scheduleFiveMinutesBeforeSalahTimes(startDate)

        // b) Start
        NotificationManager.shared.scheduleShieldActivated(at: startDate)

        // c) End
        NotificationManager.shared.scheduleShieldRemoved(at: endDate)
        print("Hey vishal this is your time for \(activity) five minutes before \(startDate) this is your start \(startDate) and this is your end \(endDate)")

        try? center.startMonitoring(activity, during: schedule)
    }
    
    private func dateForToday(hour: Int, minute: Int) -> Date {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        comps.hour = hour
        comps.minute = minute
        return Calendar.current.date(from: comps) ?? Date()
    }
}

