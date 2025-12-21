//
//  BypassModeCard.swift
//  Ruku
//
//  Created by Vishal Singh on 22/12/25.
//

import SwiftUI

struct BypassModeCard: View {
    
    @Binding var bypassMode: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                Image("Eye")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .frame(width: 36, height: 36)
                    .background(Color.lightGrayColor)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Show Bypass Button")
                        .font(.inter(weight: .medium, size: 18))
                        .foregroundStyle(Color.textSecondaryColor)
                    
                    
                    Text("Display a button to bypass focus mode during an active session.")
                        .font(.inter(weight: .regular, size: 15))
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Toggle("", isOn: $bypassMode)
                    .labelsHidden()
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 25)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    BypassModeCard(bypassMode: .constant(true))
}
