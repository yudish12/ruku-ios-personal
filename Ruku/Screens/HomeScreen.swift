//
//  HomeScreen.swift
//  Ruku
//
//  
//

import SwiftUI
import FamilyControls
import Combine

struct HomeScreen: View {
    @EnvironmentObject var shieldViewModel: ShieldViewModel
    @EnvironmentObject private var appState: AppStateViewModel
    @AppStorage("isBlocked") private var isBlocked: Bool = false
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var showSalahTimingsSetup = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isBlocked {
                    SalahMode(isBlocked: $isBlocked, shieldViewModel: shieldViewModel)
                        .transition(.opacity)
                } else {
                    content()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: isBlocked)
        }
        .sheet(isPresented: $showSalahTimingsSetup) {
            NavigationStack {
                EditSalahTimingsView()
            }
        }
    }
    
    func content() -> some View {
        ZStack {
            Color.backgroundTealColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Fixed Header
                headerView()
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .background(Color.backgroundTealColor)
                
                // MARK: - Scrollable Content
                ScrollView {
                        VStack(spacing: 20) {
                            // MARK: - Next Salah Card
                            if let nextSalah = viewModel.nextSalah {
                                NextSalahCard(salah: nextSalah)                                    .padding(.horizontal)
                            }

                            
                            // MARK: - Today's Salah
                            todaysSalahView()
                                .padding(.horizontal)
                            
                            // MARK: - Your Progress
                            progressView()
                                .padding(.horizontal)
                            
                            Spacer(minLength: 100)
                        }
                        .padding(.top, 8)
                        
                }
            }
        }
        .onAppear {
            viewModel.loadSalahTimes()
        }
        .onChange(of: viewModel.todaysSalahTimes) { oldValue, newValue in
            if newValue.isEmpty && !oldValue.isEmpty {
                // Times were cleared
            } else if newValue.isEmpty {
                // No times configured
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showSalahTimingsSetup = true
                }
            }
        }
    }
    
    // MARK: - Header View
    private func headerView() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Tracking Dashboard")
                    .font(.inter(weight: .bold, size: 28))
                    .foregroundColor(.white)
                
                Text(viewModel.todayDateString)
                    .font(.inter(weight: .regular, size: 14))
                    .foregroundColor(.white.opacity(0.8))
                
                Text(viewModel.islamicDateString)
                    .font(.inter(weight: .regular, size: 12))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Today's Salah View
    private func todaysSalahView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Salah")
                .font(.inter(weight: .bold, size: 20))
                .foregroundColor(.white)
            
            if viewModel.todaysSalahTimes.isEmpty {
                VStack(spacing: 12) {
                    Text("No salah times configured")
                        .font(.inter(weight: .regular, size: 14))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Button {
                        showSalahTimingsSetup = true
                    } label: {
                        Text("Setup Salah Times")
                            .font(.inter(weight: .semibold, size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.buttonGreenColor)
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            } else {
                VStack(spacing: 16) {
                    ForEach(viewModel.todaysSalahTimes, id: \.id) { salah in
                        TodaySalahRow(
                            salah: salah,
                            isCompleted: viewModel.isSalahCompleted(salah.title),
                            onToggle: {
                                viewModel.toggleSalahCompletion(salah.title)
                            }
                        )
                    }
                }
            }
        }
    }
    
    // MARK: - Progress View
    private func progressView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Progress")
                .font(.inter(weight: .bold, size: 20))
                .foregroundColor(.white)
            
            ProgressCard(
                selectedPeriod: $viewModel.selectedPeriod,
                currentWeekStart: $viewModel.currentWeekStart,
                currentMonth: $viewModel.currentMonth,
                currentYear: $viewModel.currentYear,
                onSalahToggle: { salahName, date in
                    viewModel.toggleSalahCompletion(salahName, for: date)
                },
                isSalahCompleted: { salahName, date in
                    viewModel.isSalahCompleted(salahName, for: date)
                },
                getCompletionCount: { date in
                    viewModel.getCompletionCount(for: date)
                },
                getWeekCompletion: {
                    viewModel.getWeekCompletionCount()
                },
                getMonthCompletion: {
                    viewModel.getMonthCompletionCount()
                }
            )
        }
    }
}

// MARK: - Home ViewModel
@MainActor
class HomeViewModel: ObservableObject {
    @Published var todaysSalahTimes: [SalahTimeDisplay] = []
    @Published var nextSalah: SalahTimeDisplay?
    @Published var selectedPeriod: ProgressPeriod = .week
    @Published var currentWeekStart: Date = Calendar.current.startOfDay(for: Date())
    @Published var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @Published var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    private let calendar = Calendar.current
    
    var todayDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return "Today, \(formatter.string(from: Date()))"
    }
    
    var islamicDateString: String {
        // Simplified - you can use a proper Islamic calendar library
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: Date())
    }
    
    func loadSalahTimes() {
        let storedTimes = SalahTimeStore.shared.loadTimes()
        
        guard !storedTimes.isEmpty else {
            todaysSalahTimes = []
            nextSalah = nil
            return
        }
        
        let now = Date()
        let today = calendar.startOfDay(for: now)
        
        // Convert stored times to display format with today's date
        todaysSalahTimes = storedTimes.map { stored in
            let timeDate = calendar.date(
                bySettingHour: stored.hour,
                minute: stored.minute,
                second: 0,
                of: today
            ) ?? today
            
            return SalahTimeDisplay(
                title: stored.title,
                time: timeDate,
                iconName: getIconName(for: stored.title)
            )
        }
        .sorted { $0.time < $1.time }
        
        // Find next salah
        nextSalah = findNextSalah(from: now)
    }
    
    private func findNextSalah(from currentTime: Date) -> SalahTimeDisplay? {
        // Check today's remaining salahs
        let remainingToday = todaysSalahTimes.filter { $0.time > currentTime }
        if let nextToday = remainingToday.first {
            return nextToday
        }
        
        // If no salahs left today, return tomorrow's first salah (Fajr)
        if let fajr = todaysSalahTimes.first(where: { $0.title.lowercased() == "fajr" }) {
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: fajr.time) ?? fajr.time
            return SalahTimeDisplay(
                title: fajr.title,
                time: tomorrow,
                iconName: fajr.iconName
            )
        }
        
        // Fallback: return first salah of today if all have passed
        return todaysSalahTimes.first
    }
    
    private func getIconName(for salahName: String) -> String {
        switch salahName.lowercased() {
        case "fajr": return "Fajr"
        case "dhuhr", "dhuh": return "dhuh"
        case "asr": return "asr"
        case "maghrib": return "maghrib"
        case "isha": return "isha"
        default: return "Fajr"
        }
    }
    
    func isSalahCompleted(_ salahName: String, for date: Date = Date()) -> Bool {
        StreakStore.shared.isSalahCompleted(salahName, for: date)
    }
    
    func toggleSalahCompletion(_ salahName: String, for date: Date = Date()) {
        if isSalahCompleted(salahName, for: date) {
            StreakStore.shared.unmarkSalahCompleted(salahName, for: date)
        } else {
            StreakStore.shared.markSalahCompleted(salahName, for: date)
        }
        objectWillChange.send()
    }
    
    func getCompletionCount(for date: Date) -> Int {
        StreakStore.shared.getCompletionCount(for: date)
    }
    
    func getWeekCompletionCount() -> Int {
        StreakStore.shared.getWeekCompletionCount(startDate: currentWeekStart)
    }
    
    func getMonthCompletionCount() -> Int {
        StreakStore.shared.getMonthCompletionCount(year: currentYear, month: currentMonth)
    }
}

// MARK: - Supporting Types
struct SalahTimeDisplay: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let time: Date
    let iconName: String
    
    static func == (lhs: SalahTimeDisplay, rhs: SalahTimeDisplay) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title && lhs.time == rhs.time && lhs.iconName == rhs.iconName
    }
}

enum ProgressPeriod {
    case week
    case month
}

#Preview {
    HomeScreen()
}
