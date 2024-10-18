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

    var comicBookLists: [any ComicBookListHandler]?

    override func setUpWithError() throws {
        leftoverList = LeftoverList.preview
        shoppingList = ShoppingList.preview

        comicBookLists = [leftoverList as Any, shoppingList as Any] as? [any ComicBookListHandler]
    }

    override func tearDownWithError() throws {}

    func test_updateComicBookPurchased() throws {
        for comicBookList in comicBookLists! {
            let comicBook = comicBookList.comicBooks.first!

            let initialValue = comicBook.purchased

            comicBookList.updateComicBookPurchased(comicBook)

            for _comicBook in comicBookList.comicBooks {
                if _comicBook == comicBook {
                    XCTAssert(_comicBook.purchased != initialValue)
                }
            }
        }
    }
    
    func test_updateComicBookSelected() throws {
        for comicBookList in comicBookLists! {
            let comicBook = comicBookList.comicBooks.first!

            let initialValue = comicBook.selected

            comicBookList.updateComicBookSelected(comicBook)

            for _comicBook in comicBookList.comicBooks {
                if _comicBook == comicBook {
                    XCTAssert(_comicBook.selected != initialValue)
                }
            }
        }
    }

}
