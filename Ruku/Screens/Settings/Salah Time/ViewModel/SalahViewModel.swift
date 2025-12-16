import SwiftUI
import Combine

struct SalahTime: Identifiable {
    let id = UUID()
    let title: String
    var time: Date
}

@MainActor
class SalahViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var allTimes: [SalahTime] = []        // All prayers from API
    @Published var mainFiveTimes: [SalahTime] = []   // Only Fajr, Dhuhr, Asr, Maghrib, Isha
    @Published var isLoading: Bool = false
    
    // MARK: - Constants
    private let mainFivePrayers: [String] = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]
    
    // MARK: - Fetch API
    func fetchSalahTimes(date: String, latitude: Double, longitude: Double) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let request = SalahTimingsRequest(date: date, latitude: latitude, longitude: longitude)
            let response = try await SalahTimingsAPI.shared.fetchTimings(request)
            
            self.allTimes = response.data.compactMap { key, value in
                guard let date = DateFormatter.salahIST.date(from: value) else { return nil }
                return SalahTime(title: key, time: date)
            }
            
            self.filterMainFive()
        } catch {
            print("Failed to fetch Salah times:", error.localizedDescription)
        }
    }
    
    // MARK: - Filter only main five prayers
    private func filterMainFive() {
        mainFiveTimes = allTimes.filter { mainFivePrayers.contains($0.title) }
            .sorted { mainFivePrayers.firstIndex(of: $0.title)! < mainFivePrayers.firstIndex(of: $1.title)! }
    }

}

