//
//  AuthAPI.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import Foundation

final class AuthAPI {

    static let shared = AuthAPI()
    private init() {}

    func login(_ request: LoginRequest) async throws -> LoginResponse {
        let response = try await APIClient.shared.request(
            .login,
            method: .post,
            body: request.toDictionary(),
            response: LoginResponse.self
        )

        // ✅ Save token
        TokenStorage.shared.save(response.data.accessToken)

        return response
    }


//    func register(_ request: RegisterRequest) async throws -> RegisterResponse {
//        try await APIClient.shared.request(
//            .register,
//            method: .post,
//            body: request.toDictionary(),
//            response: RegisterResponse.self
//        )
//    }
//
//    func verifyOTP(_ request: VerifyOTPRequest) async throws -> VerifyOTPResponse {
//        try await APIClient.shared.request(
//            .verifyOTP,
//            method: .post,
//            body: request.toDictionary(),
//            response: VerifyOTPResponse.self
//        )
//    }
}
