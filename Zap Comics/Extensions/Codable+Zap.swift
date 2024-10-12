//
//  Codable+Zap.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
