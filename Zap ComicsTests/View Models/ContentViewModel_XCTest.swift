//
//  ContentViewModel+Testing.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/11/24.
//

import XCTest
import Networking
@testable import Zap_Comics

@MainActor
final class ContentViewModel_Testing: XCTestCase {

    override func setUpWithError() throws {
        ZapNetwork.service.fakePOST("/sessions", fileName: "UserResponse.json")
        ZapNetwork.service.fakePOST("/users", fileName: "UserResponse.json")
    }

    override func tearDownWithError() throws {}

    func test_login_shouldSetCurrentUser() throws {
        Task {
            ContentViewModel().login()
            XCTAssert(User.current != nil)
        }
    }

    func test_logOut_shouldClearCurrentUser() throws {
        Task {
            User.preview.save()

            ContentViewModel().logOut()

            XCTAssert(User.current == nil)
        }
    }

    func test_register_shouldCreateCurrentUser() throws {
        Task {
            ContentViewModel().register()
            XCTAssert(User.current != nil)
        }
    }

}
