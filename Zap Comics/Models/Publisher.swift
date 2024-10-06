//
//  Publisher.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation
import SwiftUI

class Publisher: Codable, Identifiable, Equatable {
    
    var id: Int
    var name: String
    @Default<Empty> var comicBooks: [ComicBook]
    
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

extension Publisher {
    static var preview: Publisher {
        Publisher(id: 1, name: "DC Comics", comicBooks: [])
    }
}
