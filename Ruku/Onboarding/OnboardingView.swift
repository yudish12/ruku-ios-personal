//
//  OnboardingView.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $appState.currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    OnboardingPageView(page: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.spring(), value: appState.currentPage)
            .pageControlColors(selected: .buttonGreenColor, normal: .white)
    
            Button {
                appState.nextOnboardingPage()
            } label: {
                Text(appState.canGoNextOnboardingPage() ? "Next" : "Continue")
                    .frame(maxWidth: .infinity)
                    .font(.inter(weight: .bold, size: 14))
                    .padding(.vertical, 12)
                    .background(Color.buttonGreenColor)
                    .foregroundStyle(.white)
                    .cornerRadius(50)
                   
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundTealColor)
    }
}

#Preview {
    
    @Previewable var appState =  AppStateViewModel()
    OnboardingView()
        .environmentObject(appState)
}
