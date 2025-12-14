//
//  AboutView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Ruku")
                .font(.inter(weight: .bold, size: 30))
                .foregroundStyle(.black)

            Text("Version 1.0.0")
                .font(.inter(weight: .regular, size: 18))
                .foregroundStyle(.black)

            Text("Helping you focus during Salah.")
                .font(.inter(weight: .medium, size: 18))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationTitle("About")
    }
}


#Preview {
    AboutView()
}
