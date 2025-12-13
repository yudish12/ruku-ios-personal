//
//  OTPTextField.swift
//  Ruku
//
//  Created by Vishal Singh on 12/12/25.
//

import SwiftUI

struct OTPTextField: View {
    @Binding var text: String
    var isFocused: Bool
    var onChange: (String) -> Void
    
    var body: some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .font(.inter(weight: .bold, size: 22))
            .keyboardType(.numberPad)
            .frame(width: 55, height: 55)
            .background(.white.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Color.blue : .gray.opacity(0.4), lineWidth: 1)
            )
            .keyboardType(.numberPad)
            .onChange(of: text) { oldValue, newValue in
                onChange(newValue)
            }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    OTPTextField(text: .constant("5"), isFocused: true, onChange: {_ in })
        .padding()
}
