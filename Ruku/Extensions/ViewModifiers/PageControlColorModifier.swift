//
//  PageControlColorModifier.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import SwiftUI

struct PageControlColorModifier: ViewModifier {
    let selected: Color
    let normal: Color
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(selected)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor(normal)
            }
    }
}

