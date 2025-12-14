//
//  TextFieldView.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct TextFieldView: View {
    let title: String
    let placeholderText: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.inter(weight: .bold, size: 18))
                .foregroundStyle(.white)
            
            TextField(placeholderText, text: $text)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundColor(Color.backgroundTealColor)
                .padding(.horizontal, 12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))

        }
    }
}
