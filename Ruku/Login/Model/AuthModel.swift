//
//  LoginModel.swift
//  Ruku
//
//  Created by Vishal Singh on 16/12/25.
//

import Foundation

enum DeviceType: String, Codable {
    case iphone
    case ipad
    case mac
}

enum Gender: String, CaseIterable, Identifiable, Codable {
    case male
    case female
    case other
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .other: return "Others"
        }
    }
}


struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
    let gender: Gender
    let deviceType: DeviceType
}


struct VerifyOtpRequest: Codable {
    let email: String
    let otp: String
}

struct LoginResponse: Codable {
    let success: Bool
    let data: User
    let message: String
}
