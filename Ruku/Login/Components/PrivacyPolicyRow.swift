import SwiftUI

struct PrivacyPolicyRow: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("By continuing, you agree to our")
                .font(.inter(weight: .regular, size: 12))
                .foregroundStyle(.white)
            
            Button {
                // Privacy Policy action
            } label: {
                Text("Privacy Policy.")
                    .font(.inter(weight: .bold, size: 12))
                    .foregroundStyle(Color.buttonGreenColor)
            }
        }
    }
}


#Preview {
    PrivacyPolicyRow()
}
