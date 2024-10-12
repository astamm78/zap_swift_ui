//
//  ShoppingList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ShoppingList: Codable, PurchasableComicBookList, Previewable {

    typealias PreviewType = ShoppingList

    let dateFormatter = DateFormatter()
    
    var id: Int
    var dateString: String

    @Default<Empty> var comicBooks: [ComicBook]
    
    var date: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "week"
        case comicBooks = "comic_books"
    }
}

class ShoppingListResponse: Codable, Previewable {
    typealias PreviewType = ShoppingListResponse

    var shoppingList: ShoppingList
    
    private enum CodingKeys: String, CodingKey {
        case shoppingList = "shopping_list"
    }
}
