//
//  OnboardingPageView.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 160, height: 160)
                .padding(.top, 80)
            
            VStack(alignment: .center, spacing: 50) {
                if page != .welcome {
                    Text("How it works?")
                        .font(.inter(weight: .bold, size: 30))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }

                
                Text(page.title)
                    .font(
                        page == .welcome
                        ? .inter(weight: .semibold, size: 64)
                        : .inter(weight: .bold, size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text(page.subtitle)
                    .font(.inter(weight: .medium, size: 16))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 32)
            }
            .padding(.top, 70)
            .padding(.horizontal, 22)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundTealColor)
    }
}


#Preview {
    OnboardingPageView(page: OnboardingPage.salahAutomaticTime)
}
