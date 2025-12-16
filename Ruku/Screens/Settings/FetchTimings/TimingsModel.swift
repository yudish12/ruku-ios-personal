//
//  TimingsModel.swift
//  Ruku
//
//  Created by yudish on 16/12/25.
//
import Foundation


enum Salah: String, CaseIterable, Codable {
    case fajr = "Fajr"
    case sunrise = "Sunrise"
    case dhuhr = "Dhuhr"
    case asr = "Asr"
    case sunset = "Sunset"
    case maghrib = "Maghrib"
    case isha = "Isha"
    case imsak = "Imsak"
    case midnight = "Midnight"
    case firstThird = "Firstthird"
    case lastThird = "Lastthird"

    var displayName: String {
        switch self {
        case .fajr: return "Fajr"
        case .sunrise: return "Sunrise"
        case .dhuhr: return "Dhuhr"
        case .asr: return "Asr"
        case .sunset: return "Sunset"
        case .maghrib: return "Maghrib"
        case .isha: return "Isha"
        case .imsak: return "Imsak"
        case .midnight: return "Midnight"
        case .firstThird: return "First Third"
        case .lastThird: return "Last Third"
        }
    }

    var uiOrder: Int {
        switch self {
        case .imsak: return 0
        case .fajr: return 1
        case .sunrise: return 2
        case .dhuhr: return 3
        case .asr: return 4
        case .sunset: return 5
        case .maghrib: return 6
        case .isha: return 7
        case .midnight: return 8
        case .firstThird: return 9
        case .lastThird: return 10
        }
    }
}

struct SalahTimingsRequest {
    let date: String
    let latitude: Double
    let longitude: Double

    func toParams() -> [String: String] {
        [
            "date": date,
            "lat": "\(latitude)",
            "lng": "\(longitude)"
        ]
    }
}


struct SalahTimingsResponse: Codable {
    let success: Bool
    let data: SalahTimes
}

struct SalahTimes: Codable {
    let times: [Salah: String]

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }

        var intValue: Int? { nil }
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var prayerTimes: [Salah: String] = [:]

        for key in container.allKeys {
            if let salah = Salah(rawValue: key.stringValue) {
                let time = try container.decode(String.self, forKey: key)
                prayerTimes[salah] = time
            }
        }

        self.times = prayerTimes
    }
}
