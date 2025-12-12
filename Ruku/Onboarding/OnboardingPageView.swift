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
            Image(page.imageName)
                .resizable()
                .frame(width: 160, height: 160)
            
            VStack(alignment: .center, spacing: 16) {
                Text(page.title)
                    .font(.inter(weight: .bold, size: 30))
                    .foregroundStyle(Color.secondaryColor)
                    .multilineTextAlignment(.center)
                
                Text(page.subtitle)
                    .font(.inter(weight: .regular, size: 16))
                    .foregroundStyle(Color.appPrimary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 60)
        }
    }
}


#Preview {
    OnboardingPageView(page: OnboardingPage.stayFocused)
}
