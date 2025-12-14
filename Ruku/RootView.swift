import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppStateViewModel
   
    var body: some View {
        switch appState.currentRoot {
        case .onboarding: OnboardingView()
        case .permission: PermissionScreen()
        case .login: LoginScreen()
        case .subscription: SubscriptionView()
        case .home: HomeScreen()
        }
    }
}


#Preview {
 
    LoginScreen()
        .environmentObject(AppStateViewModel())
}
