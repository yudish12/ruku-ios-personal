//
//  TimingsModel.swift
//  Ruku
//
//  Created by yudish on 16/12/25.
//
import Foundation

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
    let data: [String: String] // Simple mapping from API
}
