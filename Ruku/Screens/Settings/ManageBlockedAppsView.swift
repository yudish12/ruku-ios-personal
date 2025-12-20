//
//  ManageBlockedAppsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI
import FamilyControls
import DeviceActivity

struct ManageBlockedAppsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppStateViewModel
    @EnvironmentObject var shieldViewModel: ShieldViewModel

    @State private var showingPicker = false
    @State private var showLimitAlert = false
    @State private var feedbackMessage: FeedbackMessage? = nil
    
    private let maxAppsCount = 3
    
    private func activityName(for title: String) -> DeviceActivityName {
        switch title {
        case "Fajr": return .fajr
        case "Dhuhr": return .dhuhr
        case "Asr": return .asr
        case "Maghrib": return .maghrib
        case "Isha": return .isha
        default: return .fajr
        }
    }
    
    private func scheduleShieldForSavedSalahTimes() {
        // Save blocked apps for extension
        ShieldStore.shared.selection = shieldViewModel.selection

        // Load saved Salah times (WHEN)
        let salahTimes = SalahTimeStore.shared.loadTimes()

        guard !salahTimes.isEmpty else {
            print("⚠️ No Salah times saved, skipping scheduling")
            return
        }

        // Schedule each Salah
        for salah in salahTimes {
            SalahScheduleManager.shared.scheduleSalah(
                activity: activityName(for: salah.title),
                hour: salah.hour,
                minute: salah.minute
            )
        }
    }

    
    // Feedback message types
    enum FeedbackMessage: Identifiable, Equatable {
        case categoriesOnly(count: Int)
        case noAppsSelected
        case limitEnforced(selected: Int, kept: Int)
        case success(count: Int)
        
        var id: String {
            switch self {
            case .categoriesOnly: return "categoriesOnly"
            case .noAppsSelected: return "noAppsSelected"
            case .limitEnforced: return "limitEnforced"
            case .success: return "success"
            }
        }
        
        static func == (lhs: FeedbackMessage, rhs: FeedbackMessage) -> Bool {
            switch (lhs, rhs) {
            case (.categoriesOnly(let lhsCount), .categoriesOnly(let rhsCount)):
                return lhsCount == rhsCount
            case (.noAppsSelected, .noAppsSelected):
                return true
            case (.limitEnforced(let lhsSelected, let lhsKept), .limitEnforced(let rhsSelected, let rhsKept)):
                return lhsSelected == rhsSelected && lhsKept == rhsKept
            case (.success(let lhsCount), .success(let rhsCount)):
                return lhsCount == rhsCount
            default:
                return false
            }
        }
    }

    private var selectedAppsCount: Int {
        shieldViewModel.selection.applicationTokens.count
    }

    var body: some View {
        ZStack {
            Color.backgroundTealColor.ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: - Navigation Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Text("Blocked Apps")
                        .font(.inter(weight: .bold, size: 20))
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                      
                        // Clear any existing feedback
                        feedbackMessage = nil
                        
                        let appsBeforeEnforcement = shieldViewModel.selection.applicationTokens.count
                        enforceAppLimit()
                        
                        let finalCount = shieldViewModel.selection.applicationTokens.count
                        
                        // Only proceed if we have apps to save
                        if finalCount > 0 {
                            scheduleShieldForSavedSalahTimes()
                            // shieldViewModel.applyShield()
                            appState.completeInitialSetup()
                            
                            // Only show success if limit wasn't enforced (limit enforced message already shown)
                            if appsBeforeEnforcement <= maxAppsCount {
                                // Show success feedback
                                feedbackMessage = .success(count: finalCount)
                                
                                // Dismiss after a short delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    dismiss()
                                }
                            } else {
                                // Limit was enforced, alert will show, just dismiss after alert
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    dismiss()
                                }
                            }
                        } else {
                            // Show message that apps need to be selected
                            feedbackMessage = .noAppsSelected
                        }
                    } label: {
                        Text("Save")
                            .font(.inter(weight: .semibold, size: 16))
                            .foregroundColor(.white)
                    }
                    .disabled(selectedAppsCount == 0)
                    .opacity(selectedAppsCount == 0 ? 0.5 : 1.0)
                }
                .padding()
                .background(Color.backgroundTealColor)

                // MARK: - Subtitle
                Text("Select the apps you wish to block during Salah.")
                    .font(.inter(weight: .regular, size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 12)

                // MARK: - Content
                ScrollView {
                    VStack(spacing: 12) {
                        // Free Plan Limit Card
                        FreePlanLimitCard(
                            blockedAppsCount: selectedAppsCount,
                            maxAppsCount: maxAppsCount,
                            onRemoveLimit: {
                                print("Remove limit tapped")
                                // Clear all selected apps
                                shieldViewModel.selection = FamilyActivitySelection()
                                shieldViewModel.removeShield()
                                feedbackMessage = nil
                            }
                        )

                        // Picker Button
                        Button {
                            showingPicker = true
                        } label: {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Text("Search for an app…")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }

                        // Selected Apps
                        if selectedAppsCount > 0 {
                            VStack(spacing: 8) {
                                ForEach(Array(shieldViewModel.selection.applicationTokens.enumerated()),
                                        id: \.offset) { index, _ in
                                    SelectedAppItem(
                                        index: index,
                                        onRemove: { removeApp(at: index) }
                                    )
                                }
                            }
                        } else {
                            EmptyStateView()
                        }
                        
                        Spacer(minLength: 20)
                        
                        
                    }
                    .padding()
                }

                UpgradeCard(onUpgrade: {
                    print("Upgrade tapped")
                }).padding(.horizontal, 16)
            }
        }
        .navigationBarHidden(true)
        // Feedback Banner
        .overlay(alignment: .top) {
            if let message = feedbackMessage {
                FeedbackBanner(message: message) {
                    feedbackMessage = nil
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(1000)
            }
        }
        .animation(.spring(response: 0.3), value: feedbackMessage)

        // MARK: - Picker Sheet
        .sheet(isPresented: $showingPicker) {
            FamilyActivityPickerSheet(selection: $shieldViewModel.selection)
        }
        // Observe selection changes in real-time
        .onChange(of: shieldViewModel.selection.applicationTokens.count) { oldCount, newCount in
            if !showingPicker && newCount > 0 {
                // Selection changed while picker is closed (after dismissal)
            }
        }
        .onChange(of: shieldViewModel.selection.categoryTokens.count) { oldCount, newCount in
            print("Categories count changed: \(oldCount) -> \(newCount)")
        }
        // Observe when picker closes to enforce limit
        .onChange(of: showingPicker) { oldValue, newValue in
            if !newValue && oldValue {
                // Check multiple times with increasing delays to catch the binding update
                let delays: [TimeInterval] = [0.3, 0.6, 1.0]
                for (index, delay) in delays.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        let appsCount = self.shieldViewModel.selection.applicationTokens.count
                        let categoriesCount = self.shieldViewModel.selection.categoryTokens.count
                        
                        
                        // Enforce on the last check or if we detect selections
                        if index == delays.count - 1 || (appsCount > 0 || categoriesCount > 0) {
                            if appsCount > 0 || categoriesCount > 0 {
                                print("📱 Selections detected, enforcing limit...")
                                self.enforceAppLimit()
                            } else if index == delays.count - 1 {
                                print("📱 No selections detected after all checks - picker may have been cancelled")
                            }
                        }
                    }
                }
            } else if newValue {
                // Picker is opening
                print("Picker opening")
                print("Current apps: \(self.shieldViewModel.selection.applicationTokens.count)")
                print("Current categories: \(self.shieldViewModel.selection.categoryTokens.count)")
            }
        }

        // MARK: - Limit Alert
        .alert("App Limit Applied", isPresented: $showLimitAlert) {
            Button("OK", role: .cancel) {
                // Clear feedback message when alert is dismissed
                feedbackMessage = nil
            }
        } message: {
            if let message = feedbackMessage, case .limitEnforced(let selected, let kept) = message {
                Text("""
You selected \(selected) apps, but only \(kept) apps can be blocked.

\(kept) apps were randomly selected and blocked.

💡 Tip: To ensure your preferred apps are blocked, select exactly \(kept) apps from the Screen Time picker.
""")
            } else {
                Text("""
You selected more than 3 apps.

Only 3 apps were randomly selected and blocked.

To ensure your preferred apps are blocked, please select only 3 apps from the Screen Time picker.
""")
            }
        }
    }

    
    // MARK: - Enforce App Limit
    private func enforceAppLimit() {
        // Get current state
        let currentApps = shieldViewModel.selection.applicationTokens
        let currentCategories = shieldViewModel.selection.categoryTokens
        let tokens = Array(currentApps)
        let categoriesCount = currentCategories.count
        
        print(" ========== ENFORCE APP LIMIT ========== ")
        print(" Current apps count: \(tokens.count) ")
        print(" Current categories count: \(categoriesCount) ")
        print(" Max apps allowed: \(maxAppsCount) ")
        
        // Create a new selection to ensure proper update
        var newSelection = FamilyActivitySelection()
        
        // Always clear categories - we only want apps
        if categoriesCount > 0 {
            print("Clearing \(categoriesCount) categories (only apps are allowed)")
            newSelection.categoryTokens = []
        }
        
        // Handle apps
        if tokens.isEmpty {
            print(" No apps selected!")
            if categoriesCount > 0 {
                // Show feedback message
                feedbackMessage = .categoriesOnly(count: categoriesCount)
            } else {
                // Show feedback message for no apps
                feedbackMessage = .noAppsSelected
            }
            // Clear everything
            shieldViewModel.selection = newSelection
        } else if tokens.count > maxAppsCount {
            
            // Randomly select 3 apps based on tokens
            let shuffled = tokens.shuffled()
            let randomThree = Array(shuffled.prefix(maxAppsCount))
            
            // Update selection with only 3 apps
            newSelection.applicationTokens = Set(randomThree)
            
            // Update the view model's selection
            shieldViewModel.selection = newSelection
            
            // Verify the update
            let finalAppsCount = shieldViewModel.selection.applicationTokens.count
            let finalCategoriesCount = shieldViewModel.selection.categoryTokens.count
            
            // Show feedback message and alert
            feedbackMessage = .limitEnforced(selected: tokens.count, kept: finalAppsCount)
            showLimitAlert = true
        } else {
            // Keep the apps but clear categories
            newSelection.applicationTokens = currentApps
            shieldViewModel.selection = newSelection
            
            let finalAppsCount = shieldViewModel.selection.applicationTokens.count
            let finalCategoriesCount = shieldViewModel.selection.categoryTokens.count
            
            // Show success message if categories were cleared
            if categoriesCount > 0 {
                feedbackMessage = .success(count: finalAppsCount)
            }
        }
        
    }

    // MARK: - Remove App
    private func removeApp(at index: Int) {
        var tokens = Array(shieldViewModel.selection.applicationTokens)
        
        print("Removing app at index \(index)")
        print("Apps before removal: \(tokens.count)")

        if index < tokens.count {
            tokens.remove(at: index)
            shieldViewModel.selection.applicationTokens = Set(tokens)
            print("Apps after removal: \(shieldViewModel.selection.applicationTokens.count)")
            // No need to call applyShield() here, user will click Save
        } else {
            print("Invalid index \(index) for \(tokens.count) apps")
        }
    }
}

// MARK: - Feedback Banner Component
struct FeedbackBanner: View {
    let message: ManageBlockedAppsView.FeedbackMessage
    let onDismiss: () -> Void
    
    @State private var isVisible = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: iconName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(iconColor)
            
            // Message
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.inter(weight: .semibold, size: 14))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.inter(weight: .regular, size: 12))
                    .foregroundColor(.white.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            // Dismiss button
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : -20)
        .onAppear {
            withAnimation(.spring(response: 0.4)) {
                isVisible = true
            }
            
            // Auto-dismiss after 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                dismissWithAnimation()
            }
        }
    }
    
    private func dismissWithAnimation() {
        withAnimation(.spring(response: 0.3)) {
            isVisible = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
    
    private var iconName: String {
        switch message {
        case .categoriesOnly:
            return "exclamationmark.triangle.fill"
        case .noAppsSelected:
            return "info.circle.fill"
        case .limitEnforced:
            return "checkmark.shield.fill"
        case .success:
            return "checkmark.circle.fill"
        }
    }
    
    private var iconColor: Color {
        switch message {
        case .categoriesOnly:
            return .orange
        case .noAppsSelected:
            return .blue
        case .limitEnforced:
            return .yellow
        case .success:
            return .green
        }
    }
    
    private var backgroundColor: Color {
        switch message {
        case .categoriesOnly:
            return Color.orange.opacity(0.9)
        case .noAppsSelected:
            return Color.blue.opacity(0.9)
        case .limitEnforced:
            return Color.yellow.opacity(0.9)
        case .success:
            return Color.green.opacity(0.9)
        }
    }
    
    private var title: String {
        switch message {
        case .categoriesOnly(let count):
            return "Categories Not Supported"
        case .noAppsSelected:
            return "No Apps Selected"
        case .limitEnforced(let selected, let kept):
            return "App Limit Applied"
        case .success(let count):
            return "Apps Saved"
        }
    }
    
    private var description: String {
        switch message {
        case .categoriesOnly(let count):
            return "You selected \(count) app categories. Please select individual apps instead (max 3 apps)."
        case .noAppsSelected:
            return "Please select apps to block during Salah. Tap the search button above to select apps."
        case .limitEnforced(let selected, let kept):
            return "You selected \(selected) apps. Only \(kept) apps were randomly selected and blocked. Select exactly \(kept) apps for better control."
        case .success(let count):
            return "\(count) app\(count == 1 ? "" : "s") will be blocked during Salah."
        }
    }
}

