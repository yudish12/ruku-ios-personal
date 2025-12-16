//
//  AuthAPI.swift
//  Ruku
//
//  Created by Yudish on 14/12/25.
//

import Foundation

final class SalahTimingsService {

    static let shared = SalahTimingsService()
    private init() {}

    func fetchTimings(_ request: SalahTimingsRequest) async throws -> SalahTimes {

        let response = try await APIClient.shared.request(
            .salahTiming,
            method: .get,
            params: request.toParams(),         
            response: SalahTimingsResponse.self
        )

        return response.data
    }
}
