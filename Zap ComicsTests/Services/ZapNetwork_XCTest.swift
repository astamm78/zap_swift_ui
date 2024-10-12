//
//  ZapNetwork_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

final class ZapNetwork_XCTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_handleResponse_returnsCorrectType() throws {
        let jsonResult = try! JSONResult(
            body: try! ComicBook.preview.encoded(),
            response: HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!,
            error: nil
        )

        let comicBook: ComicBook? = ZapNetwork.self.handleResponse(jsonResult)
        XCTAssert(comicBook != nil)

        let publisher: Publisher? = ZapNetwork.self.handleResponse(jsonResult)
        XCTAssert(publisher == nil)
    }

}
