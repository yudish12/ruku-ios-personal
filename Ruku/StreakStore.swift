import Foundation

struct DailyStreak: Codable, Identifiable, Equatable {
    let id: UUID
    var date: Date
    var completedSalahs: [String] // Array of salah names completed that day
    
    init(id: UUID = UUID(), date: Date, completedSalahs: [String] = []) {
        self.id = id
        self.date = date
        self.completedSalahs = completedSalahs
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case completedSalahs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        let timeInterval = try container.decode(TimeInterval.self, forKey: .date)
        date = Date(timeIntervalSince1970: timeInterval)
        completedSalahs = try container.decode([String].self, forKey: .completedSalahs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date.timeIntervalSince1970, forKey: .date)
        try container.encode(completedSalahs, forKey: .completedSalahs)
    }
}

final class StreakStore {
    static let shared = StreakStore()
    
    private let defaults = UserDefaults(
        suiteName: "group.com.yud.Ruku"
    )!
    
    private let streaksKey = "salah_streaks"
    private let calendar = Calendar.current
    
    // Save streaks
    func saveStreaks(_ streaks: [DailyStreak]) {
        // Only keep last 7 weeks (49 days)
        let cutoffDate = calendar.date(byAdding: .day, value: -49, to: Date()) ?? Date()
        let filteredStreaks = streaks.filter { $0.date >= cutoffDate }
        
        let data = try? JSONEncoder().encode(filteredStreaks)
        defaults.set(data, forKey: streaksKey)
    }
    
    // Load all streaks
    func loadStreaks() -> [DailyStreak] {
        guard let data = defaults.data(forKey: streaksKey),
              let streaks = try? JSONDecoder().decode([DailyStreak].self, from: data)
        else { return [] }
        
        // Clean up old data (older than 7 weeks)
        let cutoffDate = calendar.date(byAdding: .day, value: -49, to: Date()) ?? Date()
        let filteredStreaks = streaks.filter { $0.date >= cutoffDate }
        
        // Save cleaned data back
        if filteredStreaks.count != streaks.count {
            saveStreaks(filteredStreaks)
        }
        
        return filteredStreaks
    }
    
    // Get streak for a specific date
    func getStreak(for date: Date) -> DailyStreak? {
        let streaks = loadStreaks()
        let dateKey = calendar.startOfDay(for: date)
        return streaks.first { calendar.isDate($0.date, inSameDayAs: dateKey) }
    }
    
    // Mark salah as completed for today
    func markSalahCompleted(_ salahName: String, for date: Date = Date()) {
        var streaks = loadStreaks()
        let dateKey = calendar.startOfDay(for: date)
        
        // Find or create streak for this date
        if let index = streaks.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: dateKey) }) {
            // Update existing streak
            if !streaks[index].completedSalahs.contains(salahName) {
                streaks[index].completedSalahs.append(salahName)
            }
        } else {
            // Create new streak
            let newStreak = DailyStreak(date: dateKey, completedSalahs: [salahName])
            streaks.append(newStreak)
        }
        
        saveStreaks(streaks)
    }
    
    // Unmark salah as completed
    func unmarkSalahCompleted(_ salahName: String, for date: Date = Date()) {
        var streaks = loadStreaks()
        let dateKey = calendar.startOfDay(for: date)
        
        if let index = streaks.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: dateKey) }) {
            streaks[index].completedSalahs.removeAll { $0 == salahName }
            
            // Remove streak if no salahs completed
            if streaks[index].completedSalahs.isEmpty {
                streaks.remove(at: index)
            }
        }
        
        saveStreaks(streaks)
    }
    
    // Check if salah is completed for a date
    func isSalahCompleted(_ salahName: String, for date: Date = Date()) -> Bool {
        guard let streak = getStreak(for: date) else { return false }
        return streak.completedSalahs.contains(salahName)
    }
    
    // Get completion count for a date
    func getCompletionCount(for date: Date) -> Int {
        guard let streak = getStreak(for: date) else { return 0 }
        return streak.completedSalahs.count
    }
    
    // Get total completion count for a week
    func getWeekCompletionCount(startDate: Date) -> Int {
        let streaks = loadStreaks()
        let weekStart = calendar.startOfDay(for: startDate)
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) ?? weekStart
        
        return streaks
            .filter { streak in
                streak.date >= weekStart && streak.date <= weekEnd
            }
            .reduce(0) { $0 + $1.completedSalahs.count }
    }
    
    // Get total completion count for a month
    func getMonthCompletionCount(year: Int, month: Int) -> Int {
        let streaks = loadStreaks()
        let components = DateComponents(year: year, month: month)
        guard let monthStart = calendar.date(from: components) else { return 0 }
        guard let monthEnd = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: monthStart) else { return 0 }
        
        return streaks
            .filter { streak in
                streak.date >= monthStart && streak.date <= monthEnd
            }
            .reduce(0) { $0 + $1.completedSalahs.count }
    }
}

