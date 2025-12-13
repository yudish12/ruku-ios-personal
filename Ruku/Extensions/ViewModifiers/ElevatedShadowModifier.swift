//
//  ElevatedShadowModifier.swift
//  Ruku
//
//  Created by Vishal Singh on 12/12/25.
//

import SwiftUI

struct ElevatedShadowModifier: ViewModifier {
    var topColor: Color = .black.opacity(0.08)
    var bottomColor: Color = .black.opacity(0.05)
    var topRadius: CGFloat = 10
    var bottomRadius: CGFloat = 8
    var topY: CGFloat = -2
    var bottomY: CGFloat = 4
    var cornerRadius: CGFloat = 12
    var background: Color = .white
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(background)
                    .shadow(color: bottomColor, radius: bottomRadius, x: 0, y: bottomY)
                    .shadow(color: topColor, radius: topRadius, x: 0, y: topY)
            )
    }
}

