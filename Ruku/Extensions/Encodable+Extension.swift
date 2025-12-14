//
//   Encodable+Extension.swift
//  Ruku
//
//  Created by Vishal Singh on 14/12/25.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data),
              let dict = json as? [String: Any] else {
            return nil
        }
        return dict
    }
}
