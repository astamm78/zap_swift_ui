//
//  ShoppingListNetwork_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

@MainActor
final class ShoppingListNetwork_XCTest: XCTestCase {

    override func setUpWithError() throws {
        ZapNetwork.service.fakeGET("/shopping_lists/current", fileName: "ShoppingListResponse.json")
        ZapNetwork.service.fakeGET("/shopping_lists/leftover", fileName: "LeftoverList.json")
    }

    override func tearDownWithError() throws {}

    func test_getShoppingList_returnsShoppingListResponse() throws {
        Task {
            let response = try? await ShoppingListNetwork.getShoppingList()
            XCTAssert(response != nil)
        }
    }

    func test_getLeftovers_returnsLeftoverList() throws {
        Task {
            let response = try? await ShoppingListNetwork.getLeftovers()
            XCTAssert(response != nil)
        }
    }

}
