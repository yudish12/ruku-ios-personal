//
//  SettingRow.swift
//  Ruku
//
//  Created by Vishal Singh on 15/12/25.
//

import SwiftUI

import SwiftUI

struct SettingsRow: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(color)

            Text(title)
                .font(.inter(weight: .medium, size: 16))
                .foregroundColor(color)
        }
    }
}


#Preview {
    SettingsRow(title: "Edit Profile", icon: "person.fill", color: .backgroundTeal)
}
