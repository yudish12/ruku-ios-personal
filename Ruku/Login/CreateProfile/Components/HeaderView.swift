//
//  HeaderView.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct HeaderView: View {
    let skipAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Create Your Profile")
                .font(.inter(weight: .bold, size: 20))
            
            Spacer()
            
            Button(action: skipAction) {
                Text("Skip")
                    .font(.inter(weight: .medium, size: 16))
                    .foregroundStyle(Color.primaryColor)
                    .padding(8)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
    }
}

