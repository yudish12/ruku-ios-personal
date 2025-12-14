//
//  NotificationsView.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import SwiftUI

struct NotificationsView: View {
    
    var body: some View {
        
        VStack {
            Text("Notification View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationTitle("Notifications")
    }
}


#Preview {
    NotificationsView()
}
