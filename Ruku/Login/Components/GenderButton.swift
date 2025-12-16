//
//  CustomButton.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct GenderButton: View {
    let gender: Gender
    @Binding var selectedGender: Gender
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(gender.displayName)
                .font(.inter(weight: .medium, size: 18))
                .padding(.vertical, 4)
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedGender == gender ? Color.buttonGreenColor : Color.backgroundTealColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.buttonGreenColor, lineWidth: selectedGender == gender ? 0 : 1)
                )
        }
    }
}
