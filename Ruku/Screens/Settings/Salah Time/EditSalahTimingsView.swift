//
//  EditSalahTimingsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct EditSalahTimingsView: View {
    @StateObject private var viewModel = SalahViewModel()
    var isInitialSetup = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Manually adjust prayer times if needed.")
                            .foregroundStyle(.white)
                        
                        if !viewModel.isLoading {
                            ForEach($viewModel.mainFiveTimes) { $salah in
                                SalahTimeRow(
                                    title: salah.title,
                                    time: $salah.time
                                )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .scrollBounceBehavior(.basedOnSize)
                
             
                if isInitialSetup {
                    NavigationLink(destination: ManageBlockedAppsView()) {
                        Text("Save Changes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.buttonGreenColor)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundTealColor.ignoresSafeArea())
            .navigationTitle("Salah Time Adjustment")
            .toolbarColorScheme(.dark, for: .navigationBar)
            
          
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        .task {
            await viewModel.fetchSalahTimes(
                date: Date().formatted(.dateTime.day().month().year()),
                latitude: 28.6139, longitude: 77.2090
            )
        }
    }
}



#Preview {
    EditSalahTimingsView(isInitialSetup: false)
}
