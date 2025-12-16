import SwiftUI
import Combine

enum AuthMode {
    case signup
    case login
}

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var mode: AuthMode = .signup
    @Published var name: String = ""
    @Published var gender: Gender = .male
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showOTPView: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var otp: [String] = Array(repeating: "", count: 6)
    @Published var timeRemaining: Int = 30
    @Published var canResend: Bool = true
    
    private var timer: Timer?
    
    var canSubmit: Bool {
        switch mode {
        case .signup:
            return !name.isEmpty &&
                   email.contains("@") &&
                   password.count >= 6
        case .login:
            return email.contains("@") &&
                   password.count >= 6
        }
    }
    
    func submit(appState: AppStateViewModel) {
        guard canSubmit else {
            errorMessage = "Please fill all required fields"
            return
        }
        
        errorMessage = nil
        
        switch mode {
        case .signup:
            Task { await signUp(appState: appState) }
        case .login:
            Task { await login(appState: appState) }
        }
    }
    
    func skipSignUp(appState: AppStateViewModel) {
        appState.skipAuthentication()
    }
    
    // MARK: - Private
    
    private func login(appState: AppStateViewModel) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let request = LoginRequest(
                email: email,
                password: password
            )
            
            _ = try await AuthAPI.shared.login(request)
            appState.authenticateUser()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func signUp(appState: AppStateViewModel) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let request = RegisterRequest(
                name: name,
                email: email,
                password: password,
                gender: gender,
                deviceType: .iphone)
            
            _ = try await AuthAPI.shared.register(request)
            showOTPView = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
 
    // MARK: - Verify Otp
    
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
            if index > 0 {
                onFocusChange(index - 1)
            }
        }
    }
    
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
        startTimer()
    }
    
    func verifyOTP(appState: AppStateViewModel) async {
        let code = otp.joined()
        guard code.count == otp.count else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do{
            let request = VerifyOtpRequest(email: email, otp: code)
            _ = try await AuthAPI.shared.verifyOTP(request)
            appState.authenticateUser()
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
}
