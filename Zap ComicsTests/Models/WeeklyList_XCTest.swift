//
//  WeeklyList_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class WeeklyList_XCTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_date_returnsObject() {
        XCTAssert(WeeklyList.preview.date != nil)
    }

    func test_updateComicBookSelected() {
        let weeklyList = WeeklyList.preview
        let publisher = weeklyList.publishers.first!

        let comicBook = publisher.comicBooks.first!

        let initialValue = comicBook.selected

        weeklyList.updateComicBookSelected(comicBook)
        let updatedPublisher = weeklyList.publishers.first(where: { $0 == publisher })!
        let updatedComic = updatedPublisher.comicBooks.first(where: { $0 == comicBook })!

        XCTAssert(updatedComic.selected != initialValue)
    }
    
    func test_updateComicBookPurchased() {
        let weeklyList = WeeklyList.preview
        let publisher = weeklyList.publishers.first!

        let comicBook = publisher.comicBooks.first!

        let initialValue = comicBook.purchased

        weeklyList.updateComicBookPurchased(comicBook)
        let updatedPublisher = weeklyList.publishers.first(where: { $0 == publisher })!
        let updatedComic = updatedPublisher.comicBooks.first(where: { $0 == comicBook })!

        XCTAssert(updatedComic.purchased != initialValue)
    }

}
