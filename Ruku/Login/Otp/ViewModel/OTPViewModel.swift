//
//  OTPViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class OTPViewModel: ObservableObject {
    
    @Published var otp: [String] = Array(repeating: "", count: 6)
    @Published var timeRemaining: Int = 30
    @Published var canResend: Bool = true
    
    private var timer: Timer?
    
    // MARK: - OTP Input Logic
    func handleInput(_ value: String, at index: Int, onFocusChange: (Int?) -> Void) {
        if value.count > 1 {
            otp[index] = String(value.last!)
        }
        
        if value.count == 1 {
            if index < otp.count - 1 {
                onFocusChange(index + 1)
            }
            else {
                onFocusChange(nil)
            }
        } else if value.isEmpty {
            if index > 0 { onFocusChange(index - 1)
 }
        }
    }
    
    // MARK: - Resend OTP
    func startTimer() {
        canResend = false
        timeRemaining = 30

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            Task { @MainActor in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.canResend = true
                    self.timer?.invalidate()
                }
            }
        }
    }

    
    func resendOTP() {
        print("Resend OTP tapped")
        startTimer()
        // Call API to resend OTP here
    }
    
    // MARK: - Verify OTP
    func verifyOTP() {
        let code = otp.joined()
        guard code.count == otp.count else { return }
        print("Verify OTP: \(code)")
        // Call your API to verify OTP
    }
}
