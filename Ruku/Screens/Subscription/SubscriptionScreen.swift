//
//  SubscriptionScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI

struct SubscriptionScreen: View {
    @State private var selected: String? = nil
    
    var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    SubscriptionCard(
                        title: "Free",
                        price: "$0",
                        features: [
                            "Block up to 3 apps",
                            "Standard Salah reminders",
                            "Basic focus session"
                        ],
                        isSelected: selected == "Free",
                        onTap: { selected = "Free" }
                    )
                    
                    SubscriptionCard(
                        title: "Premium",
                        price: "$4.99",
                        features: [
                            "Unlimited app blocking",
                            "Advanced Salah reminders",
                            "Advanced focus sessions",
                            "Custom themes",
                            "Detailed analytics"
                        ],
                        isSelected: selected == "Premium",
                        onTap: { selected = "Premium" }
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                
                Button {} label: {
                        Text("Restore Purchase")
                        .font(.inter(weight: .bold, size: 14))
                        .foregroundStyle(Color.green)
                        .underline(true,color: .green)
                    
                }
              
                Text("Payment will be charged to your Apple Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.")
                    .font(.inter(weight: .regular, size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)
                    .padding(.top, 12)
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(Color.backgroundTealColor)
            .navigationTitle("Subscription")
    }
}

#Preview {
    SubscriptionScreen()
}
