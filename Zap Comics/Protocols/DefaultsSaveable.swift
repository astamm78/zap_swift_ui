//
//  DefaultsSaveable.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/19/24.
//

import Foundation

protocol DefaultsSaveable: Codable {
    associatedtype SaveType: Decodable
    func save() -> Bool
    static func clearCurrent() -> Bool
    static var current: SaveType? { get }
}

extension DefaultsSaveable {
    @discardableResult
    func save() -> Bool {
        guard let encoded = try? JSONEncoder().encode(self) else {
            return false
        }
        
        UserDefaults.standard.set(encoded, forKey: String(describing: SaveType.self))
        
        return UserDefaults.standard.synchronize()
    }
    
    @discardableResult
    static func clearCurrent() -> Bool {
        UserDefaults.standard.removeObject(forKey: String(describing: SaveType.self))

        return UserDefaults.standard.synchronize()
    }
    
    static var current: SaveType? {
        guard let encoded = UserDefaults.standard.data(forKey: String(describing: SaveType.self)) else {
            return nil
        }
        
        return try? JSONDecoder().decode(SaveType.self, from: encoded)
    }
}
