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

        if let token = response.data.accessToken {
            TokenStorage.shared.save(token)
        }

        return response
    }


    func register(_ request: RegisterRequest) async throws -> LoginResponse {
        try await APIClient.shared.request(
            .register,
            method: .post,
            body: request.toDictionary(),
            response: LoginResponse.self
        )
    }

    func verifyOTP(_ request: VerifyOtpRequest) async throws -> LoginResponse {
        let response = try await APIClient.shared.request(
            .verifyOtp,
            method: .post,
            body: request.toDictionary(),
            response: LoginResponse.self
        )
        
        if let token = response.data.accessToken {
            TokenStorage.shared.save(token)
        }
        return response
    }
}
