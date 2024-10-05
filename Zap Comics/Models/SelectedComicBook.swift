//
//  SelectedComicBook.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import Foundation

class SelectedComicBook: ComicBook {
    
    var purchased: Bool?
    var publisher: String?
    
    enum CodingKeys: String, CodingKey {
        case purchased
        case publisher
    }
    
}
