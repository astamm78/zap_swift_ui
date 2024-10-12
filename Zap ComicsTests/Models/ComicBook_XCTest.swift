//
//  ComicBook_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class ComicBook_XCTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    // MARK: - Default Values

    func test_title_defaultsToEmptyString() throws {
        let comicBook = ComicBook.customPreview(from: "ComicBook_defaults")
        XCTAssert(comicBook.title == "")
    }

    func test_selected_defaultsToFalse() throws {
        let comicBook = ComicBook.customPreview(from: "ComicBook_defaults")
        XCTAssert(comicBook.selected == false)
    }

    func test_followed_defaultsToFalse() throws {
        let comicBook = ComicBook.customPreview(from: "ComicBook_defaults")
        XCTAssert(comicBook.followed == false)
    }

    func test_purchased_defaultsToFalse() throws {
        let comicBook = ComicBook.customPreview(from: "ComicBook_defaults")
        XCTAssert(comicBook.purchased == false)
    }

    // MARK: - VAR Wrappers

    func test_imageURL_returnsAURL() throws {
        let comicBook = ComicBook.preview
        XCTAssert(comicBook.imageURL != nil)
    }

    // MARK: - Equatable

    func test_equatable_shouldMatchOnID() throws {
        let comicBook1 = ComicBook.preview
        let comicBook2 = ComicBook.preview

        XCTAssert(comicBook1 == comicBook2)

        comicBook2.id = 9999

        XCTAssert(comicBook1 != comicBook2)
    }

}
