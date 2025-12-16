//
//  AppStateViewModel.swift
//  Ruku
//
//  Created by Vishal Singh
//

import SwiftUI
import Combine

// MARK: - Root Navigation Screens
enum RootScreen {
    case onboarding
    case permission
    case login
    case initialSetup   // Subscription + Salah Timing + App Block
    case home
}

// MARK: - App State ViewModel
@MainActor
final class AppStateViewModel: ObservableObject {

    // MARK: - Persistent App State

    /// User has completed onboarding screens
    @AppStorage("hasCompletedIntro")
    var hasCompletedIntro: Bool = false

    /// User has granted all required permissions
    @AppStorage("hasGrantedRequiredPermissions")
    var hasGrantedRequiredPermissions: Bool = false

    /// User is authenticated (login / OTP verified)
    @AppStorage("isUserAuthenticated")
    var isUserAuthenticated: Bool = false

    /// User intentionally skipped authentication
    @AppStorage("didUserSkipAuthentication")
    var didUserSkipAuthentication: Bool = false

    /// User completed mandatory first-time setup
    /// (Subscription + Salah Timing + App Block)
    @AppStorage("hasCompletedInitialSetup")
    var hasCompletedInitialSetup: Bool = false
    
    @AppStorage("isFirstLaunch")
    var isFirstLaunch: Bool = true


    // MARK: - Onboarding UI State
    @Published var currentPage: Int = 0

    // MARK: - Onboarding Logic

    func nextOnboardingPage() {
        if canGoNextOnboardingPage() {
            currentPage += 1
        } else {
            hasCompletedIntro = true
            isFirstLaunch = false
        }
    }
    
    func canGoNextOnboardingPage() -> Bool {
        currentPage < OnboardingPage.allCases.count - 1
    }

    // MARK: - Permissions

    func grantRequiredPermissions(_ isGranted: Bool = true) {
        hasGrantedRequiredPermissions = isGranted
    }

    // MARK: - Authentication

    func authenticateUser(_ isAuthenticated: Bool = true) {
        isUserAuthenticated = isAuthenticated
    }

    func skipAuthentication(_ isSkipping: Bool = true) {
        didUserSkipAuthentication = isSkipping
    }

    // MARK: - Initial Setup Flow

    /// Call this when Subscription + Salah Timing + App Block is finished
    func completeInitialSetup(_ completed: Bool = true) {
        hasCompletedInitialSetup = completed
        isUserAuthenticated = completed
    }

    // MARK: - Logout (Optional but recommended)

    func logout(_ isLoggingOut: Bool = true) {
        isUserAuthenticated = isLoggingOut
        didUserSkipAuthentication = isLoggingOut
        hasCompletedInitialSetup = isLoggingOut
    }

    // MARK: - Root Navigation Decision

    var currentRoot: RootScreen {
        if !hasCompletedIntro {
            return .onboarding
        }

        if !hasGrantedRequiredPermissions {
            return .permission
        }

        if !isUserAuthenticated && !didUserSkipAuthentication {
            return .login
        }

        if !hasCompletedInitialSetup {
            return .initialSetup
        }

        return .home
    }
}

