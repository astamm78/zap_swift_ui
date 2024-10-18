//
//  LeftoverList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation

class LeftoverList: Codable, Previewable, ComicBookListHandler, ObservableObject {
    
    typealias PreviewType = LeftoverList
    
    @Published var comicBooks: [ComicBook]
    
    private enum CodingKeys: String, CodingKey {
        case comicBooks = "shopping_lists"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        comicBooks = try container.decodeIfPresent([ComicBook].self, forKey: .comicBooks) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(comicBooks, forKey: .comicBooks)
    }
    
    init(comicBooks: [ComicBook] = []) {
        self.comicBooks = comicBooks
    }
    
}
