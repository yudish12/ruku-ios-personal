//
//  OnboardingPage.swift
//  Ruku
//
//  Created by Vishal Singh on 09/12/25.
//

import Foundation

enum OnboardingPage: Int, CaseIterable {
    case welcome
    case salahAutomaticTime
    case blockApps
    case unlockApps
    
    
    var title: String {
        switch self {
        case .welcome:
            "Assalam\nAlaikum!"
        case .salahAutomaticTime:
            "We detect Salah times automatically"
        case .blockApps:
            "We block distracting apps during Salah"
        case .unlockApps:
            "Tap “I Finished Praying” to unlock your apps"
        }
    }
    
    var subtitle: String {
        switch self {
        case .welcome:
            "Welcome to RUKU — your companion for staying focused during Salah.\nBlock Distractions, Stay Mindful, and Build Consistency in your daily prayers."
        case .salahAutomaticTime:
            "We use your location and preferred  calculation method to determine accurate  prayer times for your region"
        case .blockApps:
            "After each azan, all selected apps become  inaccessible—so you can stay focused  on  your salah without notifications or  temptations"
        case .unlockApps:
            "Once you complete your salah, Open RUKU  and confirm your prayer to unlock all  blocked apps instantly"
        }
    }
    
}
