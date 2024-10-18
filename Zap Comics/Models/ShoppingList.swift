//
//  ShoppingList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ShoppingList: Codable, ComicBookListHandler, Previewable, ObservableObject {

    typealias PreviewType = ShoppingList

    let dateFormatter = DateFormatter()
    
    var id: Int
    var dateString: String

    @Published var comicBooks: [ComicBook]
    
    var date: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "week"
        case comicBooks = "comic_books"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        dateString = try container.decode(String.self, forKey: .dateString)
        comicBooks = try container.decode([ComicBook].self, forKey: .comicBooks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(dateString, forKey: .dateString)
        try container.encode(comicBooks, forKey: .comicBooks)
    }
    
    init(
        id: Int,
        dateString: String,
        comicBooks: [ComicBook] = []
    ) {
        self.id = id
        self.dateString = dateString
        self.comicBooks = comicBooks
    }
}

struct ShoppingListResponse: Codable, Previewable {
    typealias PreviewType = ShoppingListResponse

    var shoppingList: ShoppingList
    
    private enum CodingKeys: String, CodingKey {
        case shoppingList = "shopping_list"
    }
}
