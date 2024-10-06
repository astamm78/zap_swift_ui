//
//  ComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ComicBook: Codable, Identifiable, Equatable {
    
    var id: Int
    @Default<Empty> var title: String
    var titleAndIssue: String
    var price: String
    var lastPurchased: String?
    var description: String
    var creators: String
    var imageURLString: String?
    var publisher: Publisher?

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
        case lastPurchased = "last_purchased"
        case description
        case creators
        case imageURLString = "image_url"
    }
    
    static func ==(lhs: ComicBook, rhs: ComicBook) -> Bool {
        lhs.id == rhs.id
    }
    
}

extension ComicBook {
    static var preview: ComicBook {
        let url = Bundle.main.url(forResource: "ComicBook", withExtension: "json")!

        let data = try? Data(contentsOf: url)
        let responseObject: ComicBook? = try? JSONDecoder().decode(self, from: data!)
        return responseObject!
    }
}
