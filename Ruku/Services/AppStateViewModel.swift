//
//  OnboardingViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI
import Combine

enum RootScreen {
    case onboarding, notification, login, subscription, home
}

class AppStateViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("hasAllowOrSkipNotification") var hasAllowOrSkipNotification = false
    @AppStorage("hasCreatedOrSkipProfile") var hasCreatedOrSkipProfile = false
    
    @Published var currentPage: Int = 0
    
    private func completeOnboarding() {
        hasCompletedOnboarding = true
    }
    
    func allowOrSkipNotification() {
        hasAllowOrSkipNotification = true
    }
    
    func completedOrSkipProfile() {
        hasCreatedOrSkipProfile = true
    }
    
    func canGoNextPage() -> Bool {
        currentPage < OnboardingPage.allCases.count - 1
    }
    
    func nextOnboardingPage() {
        if canGoNextPage() {
            currentPage += 1
        } else {
            completeOnboarding()
        }
    }
    
    var currentRoot: RootScreen {
        if !hasCompletedOnboarding {
            return .onboarding
        } else if !hasAllowOrSkipNotification {
            return .notification
        } else if !hasCreatedOrSkipProfile {
            return .login
        } else {
            return .home
        }
    }
}



