//
//  SalahMode.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct SalahMode: View {
    @Binding var isBlocked: Bool
    let shieldViewModel: ShieldViewModel

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                Text("Its time for Salah")
                    .font(.inter(weight: .bold, size: 35))
                    .padding(.top, 250)
                    .padding(.bottom, 20)
                
                Text("This app is temporarily blocked\nto help\nyou maintain focus.")
                    .font(.inter(weight: .regular, size: 18))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button {
                    shieldViewModel.removeShield()
                    isBlocked = false
                } label: {
                    Text("I Have Completed My Salah")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .font(.inter(weight: .bold, size: 18))
                        .foregroundStyle(.white)
                        .background(Color.backgroundTealColor.opacity(0.8))
                        .clipShape(Capsule())
                }
                
                Button {
                    // Do SOmeting
                } label: {
                    Text("Salah is not obligatory for me")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .font(.inter(weight: .bold, size: 15))
                        .foregroundStyle(Color.backgroundTealColor.opacity(0.8))
                        .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SalahMode(isBlocked: .constant(false), shieldViewModel: ShieldViewModel())
}
