//
//  SegmentButton.swift
//  Ruku
//
//  Created by Vishal Singh on 13/12/25.
//

import SwiftUI

struct SegmentButton: View {
    
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.inter(weight: .bold, size: 18))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 50)
                .background(isSelected ? Color.buttonGreenColor : Color.white)
                .foregroundColor(isSelected ? .white: Color.buttonGreenColor)
                .cornerRadius(10)
        }
    }
}

#Preview {
    SegmentButton(title: "Login", isSelected: true, action: {})
}
