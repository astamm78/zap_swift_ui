//
//  ComicBookList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation

protocol ComicBookList {
    var comicBooks: [ComicBook] { get set }
}

extension ComicBookList {
    mutating func allComicsSelected() -> Self {
        let comicBooks = self.comicBooks

        comicBooks.forEach { comicBook in
            comicBook.selected = true
        }

        self.comicBooks = comicBooks
        return self
    }

    mutating func updateComicBook(_ comicBook: ComicBook) {
        guard let _comicBook = comicBooks.first(where: { $0.id == comicBook.id })  else {
            return
        }

        _comicBook.purchased.toggle()
    }
}
