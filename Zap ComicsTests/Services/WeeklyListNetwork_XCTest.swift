//
//  WeeklyListNetwork_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

final class WeeklyListNetwork_XCTest: XCTestCase {

    override func setUpWithError() throws {
        ZapNetwork.service.fakeGET("/weekly_lists/current/by_publisher", fileName: "WeeklyListResponse.json")
    }

    override func tearDownWithError() throws {}

    func test_getWeeklyList_returnsWeeklyListResponse() throws {
        Task {
            let response = try? await WeeklyListNetwork.getWeeklyList()
            XCTAssert(response != nil)
        }
    }

}
