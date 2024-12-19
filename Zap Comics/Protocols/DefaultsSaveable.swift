//
//  DefaultsSaveable.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/19/24.
//

import Foundation

protocol DefaultsSaveable: Codable {
    associatedtype SaveType: Decodable
    func save(completion: @escaping (Bool) -> Void)
    static func clearCurrent() -> Bool
    static var current: SaveType? { get }
}

extension DefaultsSaveable {
    func save(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let encoded = try? JSONEncoder().encode(self) else {
                completion(false)
                return
            }
            
            UserDefaults.standard.set(encoded, forKey: String(describing: SaveType.self))
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
    
    @discardableResult
    static func clearCurrent() -> Bool {
        UserDefaults.standard.removeObject(forKey: String(describing: SaveType.self))
        return true
    }
    
    static var current: SaveType? {
        guard let encoded = UserDefaults.standard.data(forKey: String(describing: SaveType.self)) else {
            return nil
        }
        return try? JSONDecoder().decode(SaveType.self, from: encoded)
    }
}
