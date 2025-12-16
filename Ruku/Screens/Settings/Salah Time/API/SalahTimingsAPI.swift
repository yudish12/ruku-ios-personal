//
//  SalahTimingsAPI.swift
//  Ruku
//
//  Created by Yudish on 14/12/25.
//

import Foundation

final class SalahTimingsAPI {

    static let shared = SalahTimingsAPI()
    private init() {}

    func fetchTimings(_ request: SalahTimingsRequest) async throws -> SalahTimingsResponse {
        return try await APIClient.shared.request(
            .salahTiming,
            method: .get,
            params: request.toParams(),         
            response: SalahTimingsResponse.self
        )
    }
}
