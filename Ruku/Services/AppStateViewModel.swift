//
//  OnboardingViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI
import Combine

enum RootScreen {
    case onboarding, permission, login, subscription, home
}

class AppStateViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("hasAllowOrPermission") var hasAllowOrPermission = false
    @AppStorage("isUserLoggedIn") var isUserLoggedIn = false
    
    @Published var currentPage: Int = 0
    
    private func completeOnboarding() {
        hasCompletedOnboarding = true
    }
    
    func allowPermission() {
        hasAllowOrPermission = true
    }
    
    func userLoggedIn() {
        isUserLoggedIn = true
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
        } else if !hasAllowOrPermission {
            return .permission
        } else if !isUserLoggedIn {
            return .login
        } else {
            return .home
        }
    }
}



