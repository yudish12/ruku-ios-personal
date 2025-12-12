//
//  View+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func pageControlColors(
        selected: Color,
        normal: Color) -> some View {
        self.modifier(PageControlColorModifier(selected: selected, normal: normal))
    }
    
    @ViewBuilder
    func borderedTextField(
        borderColor: Color = .gray,
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 12,
        lineWidth: CGFloat = 1
    ) -> some View {
        self
            .padding(12)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
    
    
}
