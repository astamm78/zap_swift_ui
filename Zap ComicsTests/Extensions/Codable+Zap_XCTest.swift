//
//  Codable+Zap_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class Codable_Zap_XCTest: XCTestCase {

    func test_encoded_returnsDataObject() throws {
        let data = try? ComicBook.preview.encoded()
        XCTAssert(data != nil)
    }

}
