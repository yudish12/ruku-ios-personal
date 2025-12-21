//
//  BypassModeView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct BypassModeView: View {
    @AppStorage("bypassModeEnabled") private var bypassMode = true
    @State private var sliderValue: Double = 5

    var body: some View {
        VStack(spacing: 30) {
           
            // Bypass Mode
           BypassModeCard(bypassMode: $bypassMode)
            
            // Block Activation Delay
           BlockActivationCard(sliderValue: $sliderValue)
            
            // Blocking Feature
            BlockingFeatureCard()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.backgroundTealColor)
        .navigationTitle("Bypass Mode")
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}


#Preview {
    BypassModeView()
}
