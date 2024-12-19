//
//  DashboardViewModel_XCTest.swift
//  Zap ComicsTests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
import Networking
@testable import Zap_Comics

@MainActor
final class DashboardViewModel_XCTest: XCTestCase {

    override func setUpWithError() throws {
        ZapNetwork.service().fakeGET("/weekly_lists/current/by_publisher", fileName: "WeeklyListResponse.json")
        ZapNetwork.service().fakeGET("/shopping_lists/current", fileName: "ShoppingListResponse.json")
        ZapNetwork.service().fakeGET("/shopping_lists/leftover", fileName: "LeftoverList.json")
    }

    override func tearDownWithError() throws {}

    func test_init_shouldSetWeeklyList() throws {
        Task {
            let vm = DashboardViewModel()
            XCTAssert(vm.weeklyList != nil)
        }
    }

    func test_init_shouldSetCurrentList() throws {
        Task {
            let vm = DashboardViewModel()
            XCTAssert(vm.currentList != nil)
        }
    }

    func test_init_shouldSetLeftovers() throws {
        Task {
            let vm = DashboardViewModel()
            XCTAssert(vm.leftoverList != nil)
        }
    }

    func test_init_setPublisher_shouldSetSelectedPublisher() throws {
        Task {
            let publisher = Publisher.preview

            let vm = DashboardViewModel()
            vm.select(publisher)
            XCTAssert(vm.selectedPublisher == publisher)
        }
    }

    func test_setComic_shouldSetSelectedComic() throws {
        Task {
            let comicBook = ComicBook.preview

            let vm = DashboardViewModel()
            vm.select(comicBook)
            XCTAssert(vm.selectedComicBook == comicBook)
        }
    }

    func test_setComic_shouldTriggerShowSheet() throws {
        Task {
            let comicBook = ComicBook.preview

            let vm = DashboardViewModel()
            vm.select(comicBook)
            XCTAssert(vm.showSheet == true)
        }
    }

    func test_dismissSheet_shouldClearSelectedComicBook() throws {
        Task {
            let vm = DashboardViewModel()
            vm.select(ComicBook.preview)
            vm.dismisSheet()
            XCTAssert(vm.selectedComicBook == nil)
        }
    }

    func test_dismissSheet_shouldUnTriggerShowSheet() throws {
        Task {
            let vm = DashboardViewModel()
            vm.select(ComicBook.preview)
            vm.dismisSheet()
            XCTAssert(vm.showSheet == false)
        }
    }


}
