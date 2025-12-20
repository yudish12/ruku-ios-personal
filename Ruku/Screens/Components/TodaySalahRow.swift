//
//  TodaySalahRow.swift
//  Ruku
//
//  Created on 18/12/25.
//

import SwiftUI

struct TodaySalahRow: View {
    let salah: SalahTimeDisplay
    let isCompleted: Bool
    let onToggle: () -> Void
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: salah.time)
    }
    
    private var imageAssetName: String {
        switch salah.title.lowercased() {
        case "fajr": return "Fajr"
        case "dhuhr", "dhuh": return "dhuh"
        case "asr": return "asr"
        case "maghrib": return "maghrib"
        case "isha": return "isha"
        default: return "Fajr"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Checkbox on left
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color.buttonGreenColor : Color.clear)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.8), lineWidth: 2)
                        )
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            // Salah name
            Text(salah.title)
                .font(.inter(weight: .medium, size: 16))
                .foregroundColor(.white)
            
            
            // Image on right of text
            Image(imageAssetName)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            Spacer()
            // Time - bolder
            Text(timeString)
                .font(.inter(weight: .semibold, size: 14))
                .foregroundColor(.white)
        }
        .padding([.top, .bottom], 8)
        .padding([.horizontal], 16)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1)
        )
        .cornerRadius(20)
    }
}

#Preview {
    VStack {
        TodaySalahRow(
            salah: SalahTimeDisplay(title: "Fajr", time: Date(), iconName: "Fajr"),
            isCompleted: true,
            onToggle: {}
        )
        TodaySalahRow(
            salah: SalahTimeDisplay(title: "Dhuhr", time: Date(), iconName: "dhuh"),
            isCompleted: false,
            onToggle: {}
        )
    }
    .padding()
    .background(Color.backgroundTealColor)
}

