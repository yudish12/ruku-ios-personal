//
//  SalahTimerStore.swift
//  Ruku
//
//  Created by yudish on 19/12/25.
//

import Foundation

struct SalahTime: Codable, Identifiable {
    let id: UUID
    let title: String
    let hour: Int
    let minute: Int
}

struct SalahLocation: Codable {
    let latitude: Double
    let longitude: Double
}

final class SalahTimeStore {
    static let shared = SalahTimeStore()

    private let defaults = UserDefaults(
        suiteName: "group.com.yourcompany.ruku"
    )!

    private let timesKey = "salah_times"
    private let locationKey = "salah_location"

    func saveTimes(_ times: [SalahTime]) {
        let data = try? JSONEncoder().encode(times)
        defaults.set(data, forKey: timesKey)
    }

    func loadTimes() -> [SalahTime] {
        guard let data = defaults.data(forKey: timesKey),
              let times = try? JSONDecoder().decode([SalahTime].self, from: data)
        else { return [] }
        return times
    }

    func saveLocation(lat: Double, lon: Double) {
        let loc = SalahLocation(latitude: lat, longitude: lon)
        let data = try? JSONEncoder().encode(loc)
        defaults.set(data, forKey: locationKey)
    }

    func loadLocation() -> SalahLocation? {
        guard let data = defaults.data(forKey: locationKey),
              let loc = try? JSONDecoder().decode(SalahLocation.self, from: data)
        else { return nil }
        return loc
    }
}
