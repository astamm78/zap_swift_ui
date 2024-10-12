//
//  ComicBookList_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class ComicBookList_XCTest: XCTestCase {

    var leftoverList: LeftoverList?
    var shoppingList: ShoppingList?

    var comicBookLists: [PurchasableComicBookList]?

    override func setUpWithError() throws {
        leftoverList = LeftoverList.preview
        shoppingList = ShoppingList.preview

        comicBookLists = [leftoverList as Any, shoppingList as Any] as? [PurchasableComicBookList]
    }

    override func tearDownWithError() throws {}

    func test_allComicsSelected() throws {
        for comicBookList in comicBookLists! {
            var mutableList = comicBookList
            mutableList = mutableList.allComicsSelected()

            for comicBook in mutableList.comicBooks {
                XCTAssert(comicBook.selected == true)
            }
        }

    }

    func test_updateComicBook() throws {
        for comicBookList in comicBookLists! {
            var mutableList = comicBookList
            let comicBook = mutableList.comicBooks.first!

            let initialValue = comicBook.purchased

            mutableList.updateComicBook(comicBook)

            for _comicBook in mutableList.comicBooks {
                if _comicBook == comicBook {
                    XCTAssert(_comicBook.purchased != initialValue)
                }
            }
        }

    }

}
