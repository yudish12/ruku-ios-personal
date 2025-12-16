//
//  ManageBlockedAppsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI
import FamilyControls

struct ManageBlockedAppsView: View {
    @EnvironmentObject var appState: AppStateViewModel
    @EnvironmentObject var shieldViewModel: ShieldViewModel

    var body: some View {
        VStack {
            FamilyActivityPicker(selection: $shieldViewModel.selection)
                .frame(maxHeight: .infinity)

            Button {
                appState.completeInitialSetup()
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.buttonGreenColor)
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}


#Preview {
    ManageBlockedAppsView()
        .environmentObject(ShieldViewModel())
        .environmentObject(AppStateViewModel())
}
