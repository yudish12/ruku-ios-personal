import SwiftUI

struct RootView: View {
    @EnvironmentObject private var permissionManager: PermissionManager
    @EnvironmentObject private var appState: AppStateViewModel
    
    var body: some View {
        Group {
            switch appState.currentRoot {
            case .onboarding: OnboardingView()
            case .permission: PermissionScreen()
            case .login: LoginScreen()
            case .initialSetup: subscriptionView(showCrossButton: true)
            case .home: HomeScreen()
            }
        }
        .onChange(of: permissionManager.allPermissionsGranted) { _, granted in
            appState.hasGrantedRequiredPermissions = granted
        }
        .task {
            appState.hasGrantedRequiredPermissions =
            permissionManager.allPermissionsGranted
        }
    }
    
    
    private func subscriptionView(showCrossButton: Bool) -> some View {
        NavigationStack {
            SubscriptionView(showCrossButton: showCrossButton)
        }
    }
}


#Preview {
    
    LoginScreen()
        .environmentObject(AppStateViewModel())
}
