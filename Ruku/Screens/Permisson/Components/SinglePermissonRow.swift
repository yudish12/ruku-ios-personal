//
//  SinglePermissonRow.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import SwiftUI

import SwiftUI

struct SinglePermissonRow: View {
    let title: String
    let icon: String
    let desctiption: String
    @Binding var isGranted: Bool
    let onClick: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .frame(width: 36, height: 40)
                    .background(Color.textTertiaryColor.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.inter(weight: .medium, size: 16))
                    
                    Text(desctiption)
                        .font(.inter(weight: .regular, size: 14))
                        .foregroundStyle(Color.textTertiaryColor)
                }
                .padding(.trailing)
                
                Button(action: onClick) {
                    if isGranted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                    } else {
                        Text("Allow")
                            .font(.inter(weight: .bold, size: 10))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.buttonGreenColor)
                            .clipShape(Capsule())
                    }
                }
                .disabled(isGranted)  // Disable button if permission granted
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

#Preview {
   
        SinglePermissonRow(
            title: "Accurate Prayer Times",
            icon: "location.circle.fill",
            desctiption: "We use your location to calculate precise Salah times for your exact position.",
            isGranted: .constant(false),
            onClick: {}
        )

}

