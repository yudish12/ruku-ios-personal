import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppStateViewModel
   
    var body: some View {
        switch appState.currentRoot {
        case .onboarding: OnboardingView()
        case .permission: PermissionScreen()
        case .login: LoginScreen()
        case .initialSetup: subscriptionView(showCrossButton: true)
        case .home: HomeScreen()
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
