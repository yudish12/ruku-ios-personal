//
//  ThemeView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct ThemeView: View {
    @AppStorage("selectedTheme") private var theme = "System"

    var body: some View {
        VStack {
            Text("Theme View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationTitle("Theme")
    }
}


#Preview {
    ThemeView()
}
