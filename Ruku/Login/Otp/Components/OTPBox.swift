//
//  OTPBox.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import SwiftUI

struct OTPBoxView: View {
    @Binding var text: String
    var isFocused: Bool
    var onChange: (String) -> Void
    
    var body: some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .font(.inter(weight: .bold, size: 22))
            .keyboardType(.numberPad)
            .frame(width: 55, height: 55)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Color.buttonGreenColor : .gray.opacity(0.4), lineWidth: 1)
            )
            .keyboardType(.numberPad)
            .onChange(of: text) { oldValue, newValue in
                onChange(newValue)
            }
    }
}

#Preview {
    OTPBox()
}
