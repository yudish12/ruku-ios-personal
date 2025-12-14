//
//  User.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let role: String
    let isEmailVerified: Bool
    let profilePicture: String?
    let location: String?
    let accessToken: String
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let success: Bool
    let data: User
    let message: String
}
