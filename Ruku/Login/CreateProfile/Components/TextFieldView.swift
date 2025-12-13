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
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.inter(weight: .bold, size: 20))
            
            TextField(placeholderText, text: $text)
                .borderedTextField()
        }
    }
}
