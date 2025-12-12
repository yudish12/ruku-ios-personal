//
//  GenderSelector.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct GenderSelector: View {
    @Binding var selectedGender: Gender
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Gender")
                .font(.inter(weight: .bold, size: 20))
            
            HStack(spacing: 12) {
                ForEach(Gender.allCases) { gender in
                    GenderButton(gender: gender, selectedGender: $selectedGender) {
                        selectedGender = gender
                    }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selectedGender)
        }
    }
}
