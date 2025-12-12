//
//  OnboardingView.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var appState = AppStateViewModel()
    
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
            .pageControlColors(selected: .secondaryColor, normal: .primaryColor)
            

            Button {
                appState.nextOnboardingPage()
            } label: {
                Text(appState.canGoNextPage() ? "Next" : "Welcome To RUKU")
                    .frame(maxWidth: .infinity)
                    .font(.inter(weight: .bold, size: 14))
                    .padding(.vertical, 12)
                    .background(Color.primaryColor)
                    .foregroundStyle(Color.white)
                    .cornerRadius(50)
                   
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundColor)
    }
}

#Preview {
    OnboardingView()
}
