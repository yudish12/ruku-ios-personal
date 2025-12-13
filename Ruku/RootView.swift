
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    
    var body: some View {
        switch appState.currentRoot {
        case .onboarding:
            OnboardingView()
        case .notification:
            NotificationScreen()
        case .login, .subscription:
            LoginScreen()
        case .home:
            HomeScreen()
        }
    }
}


#Preview {
    
    @Previewable @StateObject var appState = AppStateViewModel()
    
    RootView()
        .environmentObject(appState)
}
