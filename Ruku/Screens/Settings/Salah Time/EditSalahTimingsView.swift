//
//  EditSalahTimingsView.swift
//  Ruku
//
//  Created by Yudish on 14/12/25.
//

import SwiftUI
import Foundation
import DeviceActivity

struct EditSalahTimingsView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel = SalahViewModel()
    @StateObject private var locationManager = LocationManager()

    @State private var shouldNavigate = false
    @State private var editableTimes: [Date] = []
    @State private var dbTimes: [StoredSalahTime] = []

    var isInitialSetup: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {

                // MARK: - Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        Text("Manually adjust prayer times if needed.")
                            .foregroundStyle(.white)

                        if !viewModel.isLoading {

                            // EDIT MODE (local DB)
                            if !isInitialSetup {
                                ForEach(Array(dbTimes.enumerated()), id: \.element.id) { index, salah in
                                    SalahTimeRow(
                                        title: salah.title,
                                        time: $editableTimes[index]
                                    )
                                }
                            }

                            // INITIAL SETUP (API)
                            else {
                                ForEach($viewModel.mainFiveTimes) { $salah in
                                    SalahTimeRow(
                                        title: salah.title,
                                        time: $salah.time
                                    )
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .scrollBounceBehavior(.basedOnSize)

                // MARK: - Fetch Button (ONLY edit mode)
                if !isInitialSetup {
                    Button {
                        loadSalahTimes()
                    } label: {
                        Text("Fetch Current Timings")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    }
                }

                // MARK: - Save Button (BOTH modes)
                Button {
                    saveTimes()
                } label: {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.buttonGreenColor)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }

                // MARK: - Navigation (ONLY onboarding)
                if isInitialSetup {
                    NavigationLink(
                        destination: ManageBlockedAppsView(),
                        isActive: $shouldNavigate
                    ) {
                        EmptyView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundTealColor.ignoresSafeArea())
            .navigationTitle("Salah Time Adjustment")
            .toolbarColorScheme(.dark, for: .navigationBar)

            // MARK: - Loading Overlay (API only)
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }

        // MARK: - On Appear
        .onAppear {
            locationManager.requestLocation()
            print(isInitialSetup)
            // Load local DB ONLY in edit mode
            if !isInitialSetup {
                let loadedTimes = SalahTimeStore.shared.loadTimes()
                dbTimes = loadedTimes

                editableTimes = loadedTimes.map { salah in
                    Calendar.current.date(
                        bySettingHour: salah.hour,
                        minute: salah.minute,
                        second: 0,
                        of: Date()
                    ) ?? Date()
                }
            } else {
                let lat = locationManager.latitude ?? 28.6139
                let lng = locationManager.longitude ?? 77.2090
                let date = Date()

                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "dd MMM yyyy"

                let formatted = formatter.string(from: date)
                Task {
                       await viewModel.fetchSalahTimes(
                           date: formatted,
                           latitude: lat,
                           longitude: lng
                       )
                   }
            }
        }

        // MARK: - Auto fetch ONLY during onboarding
        .onChange(of: viewModel.mainFiveTimes) { _, newTimes in
            guard !isInitialSetup, !newTimes.isEmpty else { return }

            // Convert API model → stored model
            let stored = newTimes.map { salah in
                let components = Calendar.current.dateComponents([.hour, .minute], from: salah.time)
                return StoredSalahTime(
                    id: UUID(),
                    title: salah.title,
                    hour: components.hour ?? 0,
                    minute: components.minute ?? 0
                )
            }

            dbTimes = stored

            editableTimes = stored.map { salah in
                Calendar.current.date(
                    bySettingHour: salah.hour,
                    minute: salah.minute,
                    second: 0,
                    of: Date()
                ) ?? Date()
            }
        }

    }

    // MARK: - Save Logic
    private func saveTimes() {
        if isInitialSetup {
            // ONBOARDING FLOW → save + push forward
            let storedTimes = viewModel.mainFiveTimes.map { salah in
                let components = Calendar.current.dateComponents([.hour, .minute], from: salah.time)
                return StoredSalahTime(
                    id: UUID(),
                    title: salah.title,
                    hour: components.hour ?? 0,
                    minute: components.minute ?? 0
                )
            }
            let center = DeviceActivityCenter()
            center.stopMonitoring([.fajr, .dhuhr, .asr, .maghrib, .isha])

            SalahTimeStore.shared.saveTimes(storedTimes)
            shouldNavigate = true

        } else {
            // EDIT FLOW → save + go back
            let storedTimes = zip(dbTimes, editableTimes).map { stored, date in
                let components = Calendar.current.dateComponents([.hour, .minute], from: date)
                return StoredSalahTime(
                    id: stored.id,
                    title: stored.title,
                    hour: components.hour ?? 0,
                    minute: components.minute ?? 0
                )
            }
            let center = DeviceActivityCenter()
            center.stopMonitoring([.fajr, .dhuhr, .asr, .maghrib, .isha])
            SalahTimeStore.shared.saveTimes(storedTimes)

            dismiss()
        }
    }
    // MARK: - Fetch API
    private func loadSalahTimes() {
        let defaultLat = 28.6139   // Delhi
        let defaultLng = 77.2090

        let lat: Double
        let lng: Double

        if let currentLat = locationManager.latitude,
           let currentLng = locationManager.longitude {
            lat = currentLat
            lng = currentLng
            SalahTimeStore.shared.saveLocation(lat: lat, lon: lng)
        } else if let saved = SalahTimeStore.shared.loadLocation() {
            lat = saved.latitude
            lng = saved.longitude
        } else {
            lat = defaultLat
            lng = defaultLng
        }

        Task {
            await viewModel.fetchSalahTimes(
                date: Date().formatted(.dateTime.day().month().year()),
                latitude: lat,
                longitude: lng
            )
        }
    }
}

#Preview {
    EditSalahTimingsView(isInitialSetup: false)
}
