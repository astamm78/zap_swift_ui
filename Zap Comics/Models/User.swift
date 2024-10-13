//
//  User.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class User: Codable, Previewable {

    typealias PreviewType = User

    static let curentUserKey: String = "current.user"
    
    var id: Int
    var photoURLString: String?
    var purchasedComicBookCount: Int?
    var comicBooksCount: Int?
    var shoppingListCount: Int?
    var username: String
    var apiKey: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case photoURLString = "photo_url"
        case username
        case apiKey = "api_key"
        case purchasedComicBookCount = "purchased_comic_books_count"
        case comicBooksCount = "comic_books_count"
        case shoppingListCount = "shopping_list_count"
    }
    
    @discardableResult
    func save() -> Bool {
        guard let encoded = try? JSONEncoder().encode(self) else {
            return false
        }
        
        UserDefaults.standard.set(encoded, forKey: User.curentUserKey)
        
        return UserDefaults.standard.synchronize()
    }

    @discardableResult
    static func clearCurrentUser() -> Bool {
        UserDefaults.standard.removeObject(forKey: User.curentUserKey)

        return UserDefaults.standard.synchronize()
    }

    static var current: User? {
        guard let encoded = UserDefaults.standard.data(forKey: User.curentUserKey) else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: encoded)
    }
    
}

class UserResponse: Codable, Previewable {
    typealias PreviewType = UserResponse

    var user: User
}
