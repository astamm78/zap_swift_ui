//
//  ComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ComicBook: Codable {
    
    var id: Int
    var titleAndIssue: String
    var price: String
    var selected: Bool
    var title: String
    var followed: Bool
    var lastPurchased: String
    var description: String
    var creators: String
    var imageURLString: String

    var imageURL: URL? {
        URL(string: imageURLString)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case titleAndIssue = "title_and_issue"
        case price
        case selected
        case title
        case followed
        case lastPurchased = "last_purchased"
        case description
        case creators
        case imageURLString = "image_url"
    }
    
}
