import SwiftUI

struct SalahMode: View {
    @Binding var isBlocked: Bool
    let shieldViewModel: ShieldViewModel

    var salahTeal: Color {
        Color(red: 8/255, green: 96/255, blue: 102/255)  // #086066
    }

    var body: some View {
        ZStack {
            salahTeal
                .ignoresSafeArea()

            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Its time for Salah")
                    .font(.inter(weight: .bold, size: 35))
                    .foregroundColor(.white)            // ← fixed
                    .padding(.top, 250)
                    .padding(.bottom, 20)

                Text("This app is temporarily blocked\nto help\nyou maintain focus.")
                    .font(.inter(weight: .regular, size: 18))
                    .foregroundColor(.white)            // ← fixed
                    .multilineTextAlignment(.center)

                Spacer()

                // MARK: - MAIN BUTTON
                Button {
                    shieldViewModel.removeShield()
                    isBlocked = false
                } label: {
                    Text("I Have Completed My Salah")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .font(.inter(weight: .bold, size: 18))
                        .foregroundColor(salahTeal)     // ← teal text
                        .background(Color.white)        // ← white button
                        .clipShape(Capsule())
                }

                // MARK: - SECONDARY BUTTON
                Button {
                    shieldViewModel.removeShield()
                    isBlocked = false
                } label: {
                    Text("Salah is not obligatory for me")
                        .underline()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .font(.inter(weight: .regular, size: 16))
                        .foregroundColor(.white)
                }
                .padding(.top, 8)
                .padding(.bottom, 60)  
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
        }
    }
}

#Preview {
    SalahMode(isBlocked: .constant(false), shieldViewModel: ShieldViewModel())
}
