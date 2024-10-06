//
//  Publisher.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class Publisher: Codable, Identifiable, Equatable {
    
    var id: Int
    var name: String
    var comicBooks: [ComicBook]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case comicBooks = "comic_books"
    }
    
    static func == (lhs: Publisher, rhs: Publisher) -> Bool {
        lhs.id == rhs.id
    }
    
}
