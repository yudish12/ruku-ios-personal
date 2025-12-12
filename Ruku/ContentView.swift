//
//  ContentView.swift
//  Ruku
//
//  Created by Vishal Singh on 07/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image("image1")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .padding(.top, 160)
                                
                VStack(alignment: .center, spacing: 16) {
                    Text("Welcome to Ruku")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .bold, size: 30))
                        .foregroundStyle(Color.secondaryColor)
                    
                    Text("Minimize distractions, maximize devotion.")
                        .frame(maxWidth: .infinity)
                        .font(.inter(weight: .regular, size: 15))
                        .foregroundStyle(Color.appPrimary)
                }
                .padding(.top, 60)
            }
            
            Spacer()
            
            Button {
                // Do something here
            } label: {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .font(.inter(weight: .bold, size: 14))
                    .padding(.vertical, 12)
                    .background(Color.primaryColor)
                    .foregroundStyle(Color.white)
                    .cornerRadius(50)
            }
            
        }
        .padding()
        .background(Color.backgroundColor)
    }
}

#Preview {
    ContentView()
}

