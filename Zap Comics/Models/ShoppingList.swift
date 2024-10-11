//
//  ShoppingList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ShoppingList: Codable {
    
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
    
    func allComicsSelected() -> Self {
        let comicBooks = self.comicBooks
        
        comicBooks.forEach { comicBook in
            comicBook.selected = true
        }
        
        self.comicBooks = comicBooks
        return self
    }
    
    func updateComicBook(_ comicBook: ComicBook) {
        guard let _comicBook = comicBooks.first(where: { $0.id == comicBook.id })  else {
            return
        }
        
        _comicBook.purchased.toggle()
    }
}

extension ShoppingList {
    static var preview: ShoppingListResponse {
        let url = Bundle.main.url(forResource: "ShoppingList", withExtension: "json")!

        let data = try? Data(contentsOf: url)
        let responseObject: ShoppingListResponse? = try? JSONDecoder().decode(ShoppingListResponse.self, from: data!)
        return responseObject!
    }
}

class ShoppingListResponse: Codable {
    var shoppingList: ShoppingList
    
    private enum CodingKeys: String, CodingKey {
        case shoppingList = "shopping_list"
    }
}
