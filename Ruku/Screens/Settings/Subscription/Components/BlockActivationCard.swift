//
//  BlockActivationCard.swift
//  Ruku
//
//  Created by Vishal Singh on 22/12/25.
//

import SwiftUI

struct BlockActivationCard: View {
    
    @Binding var sliderValue: Double
    
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
                    Text("Block Activation Delay")
                        .font(.inter(weight: .medium, size: 18))
                        .foregroundStyle(Color.textSecondaryColor)
                    
                    
                    Text("Start Blocking After Azan")
                        .font(.inter(weight: .regular, size: 15))
                        .foregroundStyle(Color.textSecondaryColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                

            }
            .padding(.bottom, 8)
          
            Slider(value: $sliderValue, in: 0...10)
                .tint(.green)
            
            HStack {
                Text("0 min")
                    .font(.inter(weight: .medium, size: 12))
                    .foregroundStyle(Color.textSecondaryColor)
                Spacer()
                Text("5 min")
                    .font(.inter(weight: .medium, size: 12))
                    .foregroundStyle(Color.textSecondaryColor)
                Spacer()
                Text("10 min")
                    .font(.inter(weight: .medium, size: 12))
                    .foregroundStyle(Color.textSecondaryColor)
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
    BlockActivationCard(sliderValue: .constant(0.5))
}
