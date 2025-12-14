//
//  TokenStorage.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import Foundation
import SwiftUI

final class TokenStorage {

    static let shared = TokenStorage()
    private init() {}

    @AppStorage("auth_token")
    private var token: String?

    func save(_ token: String) {
        self.token = token
    }

    func clear() {
        token = nil
    }

    func get() -> String? {
        token
    }
}
