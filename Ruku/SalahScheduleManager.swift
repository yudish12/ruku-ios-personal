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

        try? center.startMonitoring(activity, during: schedule)
    }

}

