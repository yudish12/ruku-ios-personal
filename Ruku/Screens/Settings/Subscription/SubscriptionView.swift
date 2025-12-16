//
//  SubscriptionView.swift
//  Ruku
//
//  Created by Vishal Singh on 11/12/25.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedSubscriptionType: SubscriptionType = .monthly
    var showCrossButton = false
    
    var body: some View {
        VStack {
//            if showCrossButton {
//                HStack {
//                    Spacer()
//                    
//                    NavigationLink(destination: EditSalahTimingsView()) {
//                        Image(systemName: "xmark")
//                            .font(.system(size: 20, weight: .medium))
//                            .padding(8)
//                            .background(.white)
//                            .foregroundColor(Color.buttonGreenColor)
//                            .clipShape(Circle())
//                    }
//                    
//                }
//                .padding()
//            }
            
            HStack {
                SegmentButton(
                    title: SubscriptionType.monthly.rawValue,
                    isSelected: selectedSubscriptionType == .monthly) {
                        selectedSubscriptionType = .monthly
                    }
                
                SegmentButton(
                    title: SubscriptionType.yearly.rawValue,
                    isSelected: selectedSubscriptionType == .yearly) {
                        selectedSubscriptionType = .yearly
                    }
            }
            .padding(2)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 30)
            
            
            SubscriptionCard(
                title: selectedSubscriptionType == .monthly ? "Month" : "Year",
                price: selectedSubscriptionType == .monthly ?  "$4.99" :"$28.99",
                features: [
                    "Unlimited app blocking",
                    "Advanced Salah reminders",
                    "Advanced focus session",
                    "Custom themes",
                    "Detailed analytics"
                ],
                subscriptionType: selectedSubscriptionType
            )
            
            
            Spacer()
            
            Text("Payment will be charged to your Apple Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.")
                .font(.inter(weight: .regular, size: 12))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .lineSpacing(4)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
            
            
            NavigationLink(destination: EditSalahTimingsView(isInitialSetup: true)) {
                Text("Continue with 7 Days Trial")
                    .font(.inter(weight: .bold, size: 14))
                    .foregroundStyle(Color.green)
                    .underline(true,color: .green)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(Color.backgroundTealColor)
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            if showCrossButton {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: EditSalahTimingsView(isInitialSetup: true)) {
                        Text("Skip")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
//                            .background(.white)
//                            .foregroundColor(Color.buttonGreenColor)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 12)}
                    }
                }
            }
        }
    }
}

#Preview {
    SubscriptionView()
}
