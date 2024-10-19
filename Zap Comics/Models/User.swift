//
//  User.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class User: Codable, Previewable, DefaultsSaveable {
    
    typealias SaveType = User
    typealias PreviewType = User

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
    
}

class UserResponse: Codable, Previewable {
    typealias PreviewType = UserResponse

    var user: User
}
