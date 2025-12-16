//
//  SalahTimeRow.swift
//  Ruku
//
//  Created by Vishal Singh on 16/12/25.
//

import SwiftUI

struct SalahTimeRow: View {
    let title: String
    @Binding var time: Date
    @State private var showPicker = false

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.inter(weight: .medium, size: 16))
            
            Spacer()
            
            HStack(spacing: 6) {
                Text(formattedTime)
                
                Button {
                    showPicker = true
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .sheet(isPresented: $showPicker) {
            TimePickerSheet(time: $time)
        }
    }
}




#Preview {
        SalahTimeRow(title: "Fajr", time: .constant(Date()))
}


