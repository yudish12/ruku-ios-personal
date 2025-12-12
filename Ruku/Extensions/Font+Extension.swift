//
//  Font+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 07/12/25.
//

import SwiftUI

extension Font {
    
    static func inter(weight: Inter, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
    
    enum Inter: String {
        case black = "Inter-Black"
        case blackItalic = "Inter-BlackItalic"
        case bold = "Inter-Bold"
        case boldItalic = "Inter-BoldItalic"
        case extraBold = "Inter-ExtraBold"
        case extraBoldItalic = "Inter-ExtraBoldItalic"
        case extraLight = "Inter-ExtraLight"
        case extraLightItalic = "Inter-ExtraLightItalic"
        case italic = "Inter-Italic"
        case light = "Inter-Light"
        case lightItalic = "Inter-LightItalic"
        case medium = "Inter-Medium"
        case mediumItalic = "Inter-MediumItalic"
        case regular = "Inter-Regular"
        case semibold = "Inter-SemiBold"
        case semiboldItalic = "Inter-SemiBoldItalic"
        case thin = "Inter-Thin"
        case thinItalic = "Inter-ThinItalic"
    }
    
}
