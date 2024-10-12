//
//  ComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ComicBook: Codable, Identifiable, Equatable, Previewable {

    typealias PreviewType = ComicBook

    var id: Int
    var titleAndIssue: String
    var price: String
    var lastPurchased: String?
    var description: String?
    var creators: String?
    var imageURLString: String?
    var publisher: Publisher?
    var shoppingList: ShoppingList?

    @Default<Empty> var title: String

    @Default<False> var selected: Bool
    @Default<False> var followed: Bool
    @Default<False> var purchased: Bool
    
    var imageURL: URL? {
        guard let imageURLString else { return nil }
        
        return URL(string: imageURLString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case titleAndIssue = "title_and_issue"
        case price
        case selected
        case title
        case followed
        case purchased
        case publisher
        case shoppingList = "shopping_list"
        case lastPurchased = "last_purchased"
        case description
        case creators
        case imageURLString = "image_url"
    }
    
    static func ==(lhs: ComicBook, rhs: ComicBook) -> Bool {
        lhs.id == rhs.id
    }
    
}

class ComicBookResponse: Codable, Previewable {
    typealias PreviewType = ComicBookResponse

    var comicBook: ComicBook

    private enum CodingKeys: String, CodingKey {
        case comicBook = "comic_book"
    }
}
