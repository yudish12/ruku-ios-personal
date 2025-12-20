//
//  ShieldStore.swift
//  Ruku
//
//  Created by yudish on 20/12/25.
//
import FamilyControls
import Foundation


final class ShieldStore {
    static let shared = ShieldStore()

    private let defaults = UserDefaults(
        suiteName: "group.com.yud.Ruku"
    )!

    private let key = "blocked_apps"

    var selection: FamilyActivitySelection {
        get {
            guard let data = defaults.data(forKey: key),
                  let sel = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
            else { return FamilyActivitySelection() }
            return sel
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            defaults.set(data, forKey: key)
        }
    }
}
