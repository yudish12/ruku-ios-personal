//
//  OnboardingPage.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import Foundation

enum OnboardingPage: Int, CaseIterable {
    case welcome
    case stayFocused
    case comfirmWithConfidence
    
    
    var title: String {
        switch self {
        case .welcome:
            "Welcome to RUKU"
        case .stayFocused:
            "Stay Focused,\nUndisturbed"
        case .comfirmWithConfidence:
            "Confirm with\nConfidence"
        }
    }
    
    var subtitle: String {
        switch self {
        case .welcome:
            "Minimize distractions, maximize devotion."
        case .stayFocused:
            "RUKU temporarily blocks chosen applications during Salah times, helping to remove digital distractions."
        case .comfirmWithConfidence:
            "After prayer time, RUKU will prompt you to confirm your Salah, helping build a consistent and mindful prayer habit."
        }
    }
    
    var imageName: String {
        switch self {
        case .welcome:
            "logo"
        case .stayFocused:
            "onboarding-2"
        case .comfirmWithConfidence:
            "onboarding-3"
        }
    }
}
