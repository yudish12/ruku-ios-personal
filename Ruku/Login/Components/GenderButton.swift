//
//  CustomButton.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    case others = "Others"
    
    var id: String { rawValue }
}

struct GenderButton: View {
    let gender: Gender
    @Binding var selectedGender: Gender
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(gender.rawValue)
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
