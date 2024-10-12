//
//  Publisher_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import SwiftUI
@testable import Zap_Comics

final class Publisher_XCTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    // MARK: - Default Values

    func test_comicBooks_defaultsToEmpty() throws {
        let publisher = Publisher.customPreview(from: "Publisher_defaults")
        XCTAssert(publisher.comicBooks.count == 0)
    }

    // MARK: - Equatable

    func test_equatable_shouldMatchOnID() throws {
        let publisher1 = Publisher.preview
        let publisher2 = Publisher.preview

        XCTAssert(publisher1 == publisher2)

        publisher2.id = 9999

        XCTAssert(publisher1 != publisher2)
    }

    // MARK: - Images

    func test_imageName() throws {
        let publisher = Publisher.preview
        publisher.name = "shards"
        XCTAssert(publisher.imageName == "logo-shards".lowercased())
    }

    func test_logoImage_returnsDefaultImage() throws {
        let publisher = Publisher.preview
        publisher.name = "shards"

        let defaultUIImage = UIImage(named: "logo-pub-default")!
        let defaultImage = Image(uiImage: defaultUIImage)

        XCTAssert(publisher.logoImage == defaultImage)
    }

    func test_logoImage_matchedPublisherImage() throws {
        let publisher = Publisher.preview

        let publisherUIImage = UIImage(named: "logo-dc comics")!
        let publisherImage = Image(uiImage: publisherUIImage)

        XCTAssert(publisher.logoImage == publisherImage)
    }

}
