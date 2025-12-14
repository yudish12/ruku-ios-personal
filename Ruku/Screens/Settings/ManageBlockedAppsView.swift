//
//  ManageBlockedAppsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI
import FamilyControls

struct ManageBlockedAppsView: View {
    @EnvironmentObject var shieldViewModel: ShieldViewModel

    var body: some View {
        VStack {
            FamilyActivityPicker(selection: $shieldViewModel.selection)
                .frame(maxHeight: .infinity)

        }
        .ignoresSafeArea(edges: .all)
        .navigationTitle("Blocked Apps")
    }
}


#Preview {
    ManageBlockedAppsView()
        .environmentObject(ShieldViewModel())
}
