//
//  ProgressCard.swift
//  Ruku
//
//  Created on 18/12/25.
//

import SwiftUI

struct ProgressCard: View {
    @Binding var selectedPeriod: ProgressPeriod
    @Binding var currentWeekStart: Date
    @Binding var currentMonth: Int
    @Binding var currentYear: Int
    
    let onSalahToggle: (String, Date) -> Void
    let isSalahCompleted: (String, Date) -> Bool
    let getCompletionCount: (Date) -> Int
    let getWeekCompletion: () -> Int
    let getMonthCompletion: () -> Int
    
    private let calendar = Calendar.current
    private let salahNames = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title and Period selector
            HStack {
                // Period selector
                HStack(spacing: 8) {
                    periodButton(.week, title: "Week")
                    periodButton(.month, title: "Month")
                }
                Spacer()
                
                // Navigation arrows - top right
                HStack(spacing: 8) {
                    Button {
                        withAnimation {
                            if selectedPeriod == .week {
                                currentWeekStart = calendar.date(byAdding: .weekOfYear, value: -1, to: currentWeekStart) ?? currentWeekStart
                            } else {
                                if currentMonth == 1 {
                                    currentMonth = 12
                                    currentYear -= 1
                                } else {
                                    currentMonth -= 1
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        withAnimation {
                            if selectedPeriod == .week {
                                currentWeekStart = calendar.date(byAdding: .weekOfYear, value: 1, to: currentWeekStart) ?? currentWeekStart
                            } else {
                                if currentMonth == 12 {
                                    currentMonth = 1
                                    currentYear += 1
                                } else {
                                    currentMonth += 1
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            if selectedPeriod == .week {
                weekView()
            } else {
                monthView()
            }
        }
        .padding(16)
        .background(Color(hex: 0x0B2422))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    // MARK: - Period Button
    private func periodButton(_ period: ProgressPeriod, title: String) -> some View {
        Button {
            withAnimation {
                selectedPeriod = period
            }
        } label: {
            Text(title)
                .font(.inter(weight: .semibold, size: 14))
                .foregroundColor(selectedPeriod == period ? Color.backgroundTealColor : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(selectedPeriod == period ? Color.white : Color.clear)
                .cornerRadius(20)
        }
    }
    
    // MARK: - Week View
    private func weekView() -> some View {
        VStack(spacing: 16) {
            // Days of week
            HStack(spacing: 8) {
                ForEach(weekDays, id: \.self) { date in
                    dayColumn(for: date)
                }
            }
            
            // Bottom section with month/year and progress
            HStack {
                // Month/Year on bottom left
                Text(monthYearString)
                    .font(.inter(weight: .medium, size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.backgroundTealColor.opacity(0.6))
                    .cornerRadius(20)
                
                Spacer()
                
                // Progress and share on bottom right
                HStack(spacing: 8) {
                    Text("\(getWeekCompletion())/35")
                        .font(.inter(weight: .bold, size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.backgroundTealColor.opacity(0.6))
                        .cornerRadius(20)
                    
                    Button {
                        // Share functionality
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.backgroundTealColor.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
    
    // MARK: - Month View
    private func monthView() -> some View {
        VStack(spacing: 16) {
            // Calendar grid would go here - simplified for now
            Text("Month view calendar")
                .font(.inter(weight: .regular, size: 12))
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity)
                .padding()
            
            // Progress indicator
            HStack {
                // Month/Year on bottom left
                Text(monthYearString)
                    .font(.inter(weight: .medium, size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.backgroundTealColor.opacity(0.6))
                    .cornerRadius(20)
                
                Spacer()
                
                // Progress and share on bottom right
                HStack(spacing: 8) {
                    Text("\(getMonthCompletion())/\(daysInMonth * 5)")
                        .font(.inter(weight: .bold, size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.backgroundTealColor.opacity(0.6))
                        .cornerRadius(20)
                    
                    Button {
                        // Share functionality
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.backgroundTealColor.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
    
    // MARK: - Day Column
    private func dayColumn(for date: Date) -> some View {
        let completionCount = getCompletionCount(date)
        let progress = Double(completionCount) / 5.0
        
        return VStack(spacing: 8) {
            // Day name
            Text(dayName(for: date))
                .font(.inter(weight: .medium, size: 10))
                .foregroundColor(.white.opacity(0.8))
            
            // Day number
            Text("\(calendar.component(.day, from: date))")
                .font(.inter(weight: .bold, size: 14))
                .foregroundColor(isToday(date) ? Color.backgroundTealColor : .white)
                .frame(width: 32, height: 32)
                .background(isToday(date) ? Color.white : Color.clear)
                .clipShape(Circle())
            
            // Progress circle - thinner ring, green fill
            ZStack {
                // Background circle - thinner, darker teal
                Circle()
                    .stroke(Color.backgroundTealColor.opacity(0.5), lineWidth: 2)
                    .frame(width: 32, height: 32)
                
                // Progress fill - green
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.buttonGreenColor, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 32, height: 32)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: progress)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            // Allow tapping on day to see details or toggle salahs
            // For now, we'll handle this in the parent view if needed
        }
    }
    
    // MARK: - Computed Properties
    private var weekDays: [Date] {
        (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: currentWeekStart)
        }
    }
    
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let date = calendar.date(from: DateComponents(year: currentYear, month: currentMonth)) ?? Date()
        return formatter.string(from: date)
    }
    
    private var daysInMonth: Int {
        let components = DateComponents(year: currentYear, month: currentMonth)
        let date = calendar.date(from: components) ?? Date()
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 30
    }
    
    private func dayName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
}

#Preview {
    ProgressCard(
        selectedPeriod: .constant(.week),
        currentWeekStart: .constant(Date()),
        currentMonth: .constant(12),
        currentYear: .constant(2025),
        onSalahToggle: { _, _ in },
        isSalahCompleted: { _, _ in false },
        getCompletionCount: { _ in 3 },
        getWeekCompletion: { 20 },
        getMonthCompletion: { 100 }
    )
    .padding()
    .background(Color.backgroundTealColor)
}

