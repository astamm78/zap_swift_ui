//
//  SessionsNetwork_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

final class SessionsNetwork_XCTest: XCTestCase {

    override func setUpWithError() throws {
        ZapNetwork.service().fakePOST("/sessions", fileName: "UserResponse.json")
        ZapNetwork.service().fakePOST("/users", fileName: "UserResponse.json")
    }

    override func tearDownWithError() throws {}

    func test_login_shouldReturnUserResponse() throws {
        Task {
            let response = try? await SessionsNetwork().login(with: "shards", and: "straugs")
            XCTAssert(response != nil)
        }
    }

    func test_register_shouldReturnUserResponse() throws {
        Task {
            let response = try? await SessionsNetwork().register(with: "shards", and: "straugs")
            XCTAssert(response != nil)
        }
    }

}
