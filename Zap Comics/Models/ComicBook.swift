//
//  ComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class ComicBook: Codable, Identifiable, Equatable, Previewable, ObservableObject {

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

    var title: String?

    @Published var selected: Bool
    @Published var followed: Bool
    @Published var purchased: Bool
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        titleAndIssue = try container.decode(String.self, forKey: .titleAndIssue)
        price = try container.decode(String.self, forKey: .price)
        selected = try container.decodeIfPresent(Bool.self, forKey: .selected) ?? false
        title = try container.decodeIfPresent(String.self, forKey: .title)
        followed = try container.decodeIfPresent(Bool.self, forKey: .followed) ?? false
        purchased = try container.decodeIfPresent(Bool.self, forKey: .purchased) ?? false
        publisher = try container.decodeIfPresent(Publisher.self, forKey: .publisher)
        shoppingList = try container.decodeIfPresent(ShoppingList.self, forKey: .shoppingList)
        lastPurchased = try container.decodeIfPresent(String.self, forKey: .lastPurchased)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        creators = try container.decodeIfPresent(String.self, forKey: .creators)
        imageURLString = try container.decodeIfPresent(String.self, forKey: .imageURLString)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(titleAndIssue, forKey: .titleAndIssue)
        try container.encode(price, forKey: .price)
        try container.encode(selected, forKey: .selected)
        try container.encode(title, forKey: .title)
        try container.encode(followed, forKey: .followed)
        try container.encode(purchased, forKey: .purchased)
        try container.encode(publisher, forKey: .publisher)
        try container.encode(shoppingList, forKey: .shoppingList)
        try container.encode(lastPurchased, forKey: .lastPurchased)
        try container.encode(description, forKey: .description)
        try container.encode(creators, forKey: .creators)
        try container.encode(imageURLString, forKey: .imageURLString)
    }
    
    static func ==(lhs: ComicBook, rhs: ComicBook) -> Bool {
        lhs.id == rhs.id
    }
    
    func setSelected() {
        self.selected = true
    }
    
}

struct ComicBookResponse: Codable, Previewable {
    typealias PreviewType = ComicBookResponse

    var comicBook: ComicBook

    private enum CodingKeys: String, CodingKey {
        case comicBook = "comic_book"
    }
}
