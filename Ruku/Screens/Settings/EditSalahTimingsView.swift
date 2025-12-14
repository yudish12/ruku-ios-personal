//
//  EditSalahTimingsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct EditSalahTimingsView: View {
    @AppStorage("salahStartTime") private var salahStartTime: Date = .now

    var body: some View {
        ScrollView {
           Text("Manually adjust prayer times if needed.")
                .foregroundStyle(Color.textSecondaryColor)
            
            VStack {
                
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationTitle("Salah Time Adjustment")
    }
}


#Preview {
    EditSalahTimingsView()
}
