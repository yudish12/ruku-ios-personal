//
//  NextSalahCard.swift
//  Ruku
//
//  Created on 18/12/25.
//

import SwiftUI

struct NextSalahCard: View {
    let salah: SalahTimeDisplay
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: salah.time)
    }
    
    private var timeUntil: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: now, to: salah.time)
        
        if let hours = components.hour, let minutes = components.minute {
            if hours > 0 {
                return "\(hours)h \(abs(minutes))m"
            } else if minutes > 0 {
                return "\(minutes)m"
            } else {
                return "Now"
            }
        }
        return ""
    }
    
    var body: some View {
        ZStack {
            Image("next-salah-bg")
                       .resizable()
                       .scaledToFill()
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .clipped()

            VStack(alignment: .leading,spacing: 16) {
                Text("Next Salah")
                    .font(.inter(weight: .medium, size: 14))
                    .foregroundColor(.white.opacity(0.8))
                
                HStack(spacing: 20){
                    Image(salah.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(salah.title)
                            .font(.inter(weight: .bold, size: 24))
                            .foregroundColor(.white)
                        
                        Text(timeString)
                            .font(.inter(weight: .bold, size: 20))
                            .foregroundColor(.white)
                }
                // Icon
                
                    
                    
                }
                // Countdown
                HStack(spacing: 4) {
                    Text("\(salah.title) in \(timeUntil)")
                        .font(.inter(weight: .regular, size: 12))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.buttonGreenColor)
                            .frame(width: geometry.size.width * progress, height: 6)
                    }
                }
                .frame(height: 6)
            }
            .padding([.horizontal], 20)
            .padding([.bottom, .top], 40)
        }
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 16))

            .contentShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var progress: Double {
        let now = Date()
        let salahTime = salah.time
        
        // If salah is today
        if Calendar.current.isDate(salahTime, inSameDayAs: now) {
            let salahStartOfDay = Calendar.current.startOfDay(for: salahTime)
            let totalMinutes = Calendar.current.dateComponents([.minute], from: salahStartOfDay, to: salahTime).minute ?? 0
            let elapsedMinutes = Calendar.current.dateComponents([.minute], from: salahStartOfDay, to: now).minute ?? 0
            
            guard totalMinutes > 0 else { return 0 }
            return min(1.0, Double(elapsedMinutes) / Double(totalMinutes))
        }
        
        return 0.0
    }
}

#Preview {
    NextSalahCard(salah: SalahTimeDisplay(
        title: "Isha'a",
        time: Date().addingTimeInterval(3600),
        iconName: "isha"
    ))
    .padding()
    .background(Color.backgroundTealColor)
}

