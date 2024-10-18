//
//  ComicBookList.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation

protocol ComicBookListHandler: ObservableObject {
    var comicBooks: [ComicBook] { get set }
}

extension ComicBookListHandler {
    func updateComicBookPurchased(_ comicBook: ComicBook) {
        for _comicBook in comicBooks {
            if _comicBook == comicBook {
                _comicBook.purchased.toggle()
            }
        }
    }
    
    func updateComicBookSelected(_ comicBook: ComicBook) {
        for _comicBook in comicBooks {
            if _comicBook == comicBook {
                _comicBook.selected.toggle()
            }
        }
    }
}
