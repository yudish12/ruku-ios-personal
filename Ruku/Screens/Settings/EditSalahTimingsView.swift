//
//  EditSalahTimingsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct EditSalahTimingsView: View {
    var isInitialSetup = false
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Manually adjust prayer times if needed.")
                    .foregroundStyle(.white)
                
                VStack {
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .scrollBounceBehavior(.basedOnSize)
            
            if isInitialSetup {
                NavigationLink(destination: ManageBlockedAppsView()) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.buttonGreenColor)
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(Color.backgroundTealColor)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("Salah Time Adjustment")
    }
}


#Preview {
    EditSalahTimingsView(isInitialSetup: true)
}
