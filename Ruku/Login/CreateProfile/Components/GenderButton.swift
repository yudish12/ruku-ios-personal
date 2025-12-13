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
                .font(.inter(weight: .bold, size: 12))
                .padding(.vertical, 8)
                .padding(.horizontal, 32)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedGender == gender ? Color.buttonGreenColor : Color.backgroundTealColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.backgroundTealColor, lineWidth: selectedGender == gender ? 0 : 1)
                )
        }
    }
}
