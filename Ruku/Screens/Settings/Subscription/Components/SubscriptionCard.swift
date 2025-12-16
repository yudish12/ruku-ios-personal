import SwiftUI

enum SubscriptionType: String {
    case monthly = "Monthly"
    case yearly = "Yearly"
}

struct SubscriptionCard: View {
    let title: String
    let price: String
    let features: [String]
    let subscriptionType: SubscriptionType
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(price)
                    .font(.inter(weight: .black, size: 30))
                
                Text("/\(title)")
                    .font(.inter(weight: .medium, size: 16))
                    .foregroundStyle(Color.backgroundTealColor)
            }
            
            Button {} label: {
                Text(title)
                    .font(.inter(weight: .bold, size: 16))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.buttonGreenColor)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(features, id: \.self) { feature in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.buttonGreenColor)
                        Text(feature)
                            .font(.inter(weight: .regular, size: 14))
                            .foregroundStyle(Color.black.opacity(0.8))
                    }
                }
            }
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .elevatedShadow()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable let subscription: SubscriptionType = .monthly
    SubscriptionCard(
        title: subscription == .monthly ? "Month" : "Year",
        price: subscription == .monthly ?  "$4.99" :"$28.99",
        features: [
            "Unlimited app blocking",
            "Advanced Salah reminders",
            "Advanced focus session",
            "Custom themes",
            "Detailed analytics"
        ],
        subscriptionType: subscription
    )
    .padding()
    .background(Color.backgroundTealColor)
}
