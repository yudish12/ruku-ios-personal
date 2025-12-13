//
//  View+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

extension View {
    
    func pageControlColors(
        selected: Color,
        normal: Color) -> some View {
        self.modifier(PageControlColorModifier(selected: selected, normal: normal))
    }
    
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
    
    func elevatedShadow(
        topColor: Color = .black.opacity(0.08),
        bottomColor: Color = .black.opacity(0.05),
        topRadius: CGFloat = 10,
        bottomRadius: CGFloat = 8,
        topY: CGFloat = -2,
        bottomY: CGFloat = 4,
        cornerRadius: CGFloat = 12,
        background: Color = .white
    ) -> some View {
        self.modifier(
            ElevatedShadowModifier(
                topColor: topColor,
                bottomColor: bottomColor,
                topRadius: topRadius,
                bottomRadius: bottomRadius,
                topY: topY,
                bottomY: bottomY,
                cornerRadius: cornerRadius,
                background: background
            )
        )
    }
}
