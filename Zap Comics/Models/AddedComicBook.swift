//
//  AddedComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation

class AddedComicBook: Codable, Previewable {

    typealias PreviewType = AddedComicBook

    var id: Int
    var publisher: Publisher
    
}

class AddedComicBookResponse: Codable, Previewable {
    typealias PreviewType = AddedComicBookResponse

    var addedComicBook: AddedComicBook
    
    private enum CodingKeys: String, CodingKey {
        case addedComicBook = "comic_book"
    }
}
