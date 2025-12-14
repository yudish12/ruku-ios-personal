//
//  BypassModeView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct BypassModeView: View {
    @AppStorage("bypassModeEnabled") private var bypassMode = false

    var body: some View {
        VStack {
            Text("By Pass Mode")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationTitle("Bypass Mode")
    }
}


#Preview {
    BypassModeView()
}
