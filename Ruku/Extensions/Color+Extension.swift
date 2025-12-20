//
//  Color+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 07/12/25.
//

import SwiftUI

extension Color {
    static let backgroundTealColor = Color("backgroundTealColor")
    static let backgroundColor = Color("backgroundColor")
    static let buttonGreenColor = Color("buttonGreenColor")
    static let textPrimaryColor = Color("textPrimaryColor")
    static let textSecondaryColor = Color("textSecondaryColor")
    static let textTertiaryColor = Color("textTertiaryColor")
    init(hex: UInt, opacity: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xff) / 255,
                green: Double((hex >> 08) & 0xff) / 255,
                blue: Double((hex >> 00) & 0xff) / 255,
                opacity: opacity
            )
        }
    
}
