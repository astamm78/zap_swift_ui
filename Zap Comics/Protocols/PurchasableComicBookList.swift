//
//  ComicBookList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation

protocol PurchasableComicBookList {
    var comicBooks: [ComicBook] { get set }
}

extension PurchasableComicBookList {
    mutating func allComicsSelected() -> Self {
        let comicBooks = self.comicBooks

        comicBooks.forEach { comicBook in
            comicBook.selected = true
        }

        self.comicBooks = comicBooks
        return self
    }

    func updateComicBook(_ comicBook: ComicBook) -> Self {
        let mutable = self

        guard let _comicBook = mutable.comicBooks.first(where: { $0.id == comicBook.id })  else {
            return self
        }

        _comicBook.purchased.toggle()
        return mutable
    }
}
