import SwiftUI

struct SubscriptionCard: View {
    let title: String
    let price: String
    let features: [String]
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.inter(weight: .bold, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(price)
                    .font(.inter(weight: .black, size: 30))
                
                Text("/ month")
                    .font(.inter(weight: .medium, size: 16))
                    .foregroundStyle(Color.primaryColor)
            }
            
            Button {} label: {
                Text(title)
                    .font(.inter(weight: .bold, size: 16))
                    .foregroundStyle(isSelected ? .white : Color.primaryColor)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(isSelected ? Color.primaryGreenColor : Color.lightGrayColor)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(features, id: \.self) { feature in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.primaryGreenColor)
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
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primaryGreenColor, lineWidth: isSelected ? 1 : 0)
        }
        .onTapGesture { onTap() }
        .padding(.horizontal)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SubscriptionCard(
        title: "Free",
        price: "$4.99",
        features: [
            "Block up to 3 apps",
            "Standard Salah reminders",
            "Basic focus session"
        ],
        isSelected: false,
        onTap: {}
    )
    .padding()
}
