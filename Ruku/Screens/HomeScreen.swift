//
//  HomeScreen.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var appState: AppStateViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button {
            appState.hasCreatedOrSkipProfile = false 
        } label: {
            Text("Back to login")
        }

    }
}

#Preview {
    HomeScreen()
}
