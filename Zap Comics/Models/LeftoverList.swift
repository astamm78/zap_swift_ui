//
//  LeftoverList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/6/24.
//

import Foundation

class LeftoverList: Codable {
    
    var comicBooks: [ComicBook]
    
    private enum CodingKeys: String, CodingKey {
        case comicBooks = "shopping_lists"
    }
    
    func allComicsSelected() -> Self {
        let comicBooks = self.comicBooks
        
        comicBooks.forEach { comicBook in
            comicBook.selected = true
        }
        
        self.comicBooks = comicBooks
        return self
    }
    
    func updateComicBook(_ comicBook: ComicBook) {
        guard let _comicBook = comicBooks.first(where: { $0.id == comicBook.id })  else {
            return
        }
        
        _comicBook.purchased.toggle()
    }
    
}

extension LeftoverList {
    static var preview: LeftoverList {
        let url = Bundle.main.url(forResource: "LeftoverList", withExtension: "json")!

        let data = try? Data(contentsOf: url)
        let responseObject: LeftoverList? = try? JSONDecoder().decode(LeftoverList.self, from: data!)
        return responseObject!
    }
}
