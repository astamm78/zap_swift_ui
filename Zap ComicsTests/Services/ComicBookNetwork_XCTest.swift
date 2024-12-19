//
//  ComicBookNetwork_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

final class ComicBookNetwork_XCTest: XCTestCase {

    let comicBook = ComicBook.preview
    let shoppingList = ShoppingList.preview

    override func setUpWithError() throws {
        ZapNetwork.service().fakePOST(
            "/selected_comic_books",
            fileName: "ComicBookResponse.json"
        )

        ZapNetwork.service().fakeDELETE(
            "/selected_comic_books/comic_book/\(comicBook.id)",
            fileName: "ComicBookResponse.json"
        )

        ZapNetwork.service().fakePUT(
            "/selected_comic_books/comic_book/\(comicBook.id)/shopping_list/\(shoppingList.id)",
            response: true
        )
    }

    override func tearDownWithError() throws {}

    func test_addedComicBookToList_returnsAddedComicBookResponse() throws {
        Task {
            let response = try? await ComicBookNetwork.addComicBookToList(comicBook)
            XCTAssert(response != nil)
        }
    }

    func test_removeComicBookFromList_returnsAddedComicBookResponse() throws {
        Task {
            let response = try? await ComicBookNetwork.removeComicBookFromList(comicBook)
            XCTAssert(response != nil)
        }
    }

    func test_updatePurchaseStatus_returnsBool() throws {
        Task {
            let response = try? await ComicBookNetwork.updatePurchaseStatus(
                for: comicBook,
                and: shoppingList,
                purchased: true
            )

            XCTAssert(response == true)
        }
    }

}
