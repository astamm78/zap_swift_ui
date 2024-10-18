//
//  Publisher.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import SwiftUI

class Publisher: Codable, Identifiable, Equatable, Previewable, ObservableObject, ComicBookListHandler {

    typealias PreviewType = Publisher

    var id: Int
    var name: String
    
    @Published var comicBooks: [ComicBook]
    
    init(id: Int, name: String, comicBooks: [ComicBook]) {
        self.id = id
        self.name = name
        self.comicBooks = comicBooks
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case comicBooks = "comic_books"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        comicBooks = try container.decodeIfPresent([ComicBook].self, forKey: .comicBooks) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comicBooks, forKey: .comicBooks)
    }
    
    static func == (lhs: Publisher, rhs: Publisher) -> Bool {
        lhs.id == rhs.id
    }
    
    var imageName: String {
        "logo-\(name.lowercased())"
    }
    
    var logoImage: Image {
        let uiImage =  (UIImage(named: imageName) ?? UIImage(named: "logo-pub-default"))!
        return Image(uiImage: uiImage)
    }
    
}
