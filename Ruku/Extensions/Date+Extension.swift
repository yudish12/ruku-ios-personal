//
//  Date+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 17/12/25.
//

import Foundation

extension DateFormatter {
    static let salahIST: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
