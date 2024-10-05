//
//  ShoppingList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ShoppingList: Codable {
    
    var id: Int
    var comicBooks: [SelectedComicBook]
    var dateString: String
    
    var date: Date {
        DateFormatter().date(from: dateString) ?? Date()
    }
    
    private enum CodinkedKeys: String, CodingKey {
        case id
        case dateString = "date_created"
        case comicBooks = "comic_books"
    }
    
}
