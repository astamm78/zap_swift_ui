//
//  User_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class User_XCTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_save_shouldSaveCurrentUser() throws {
        let user = User.preview
        user.save { _ in
            XCTAssert(User.current != nil)
        }
    }

}
