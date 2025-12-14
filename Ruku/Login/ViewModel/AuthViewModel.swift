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
    @Published var showOTP: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    var canSubmit: Bool {
        mode == .signup
        ? !name.isEmpty && !email.isEmpty && !password.isEmpty
        : !email.isEmpty && !password.isEmpty
    }

    func submit(appState: AppStateViewModel) {
        guard canSubmit else {
            errorMessage = "Please fill all required fields"
            return
        }

        errorMessage = nil

        switch mode {
        case .signup:
            showOTP = true
        case .login:
            Task {
                await login(appState: appState)
            }
        }
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
//            print("Hey VIshal this is login Response")
//            print(response)
            appState.userLoggedIn()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
