//
//  AddedComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation

class AddedComicBook: Codable {
    
    var id: Int
    var publisher: Publisher
    
}

class AddedComicBookResponse: Codable {
    var addedComicBook: AddedComicBook
    
    private enum CodingKeys: String, CodingKey {
        case addedComicBook = "comic_book"
    }

}
