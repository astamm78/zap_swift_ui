//
//  LeftoverList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation

class LeftoverList: Codable, Previewable, PurchasableComicBookList {

    typealias PreviewType = LeftoverList

    var comicBooks: [ComicBook]
    
    private enum CodingKeys: String, CodingKey {
        case comicBooks = "shopping_lists"
    }
    
}
