//
//  Dashboard_XCTest.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/13/24.
//

import XCTest

final class Dashboard_XCTest: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append(UITestArguments.loggedIn)
        app.launch()
    }

    func test_dashboardLoadsForLoggedInUser() throws {
        DashboardScreen(app: app)
            .verifyDashboardScreen()
    }

    func test_logout() throws {
        DashboardScreen(app: app)
            .tapMenu()
            .tapLogOut()
            .verifyLoginScreen()
    }

    func test_newComicsLoadsByDefault() throws {
        DashboardScreen(app: app)
            .verifyNewComicsTabButtonIsSelected()
    }

    func test_tappingNewComicsViewLoadsCorrectView() throws {
        DashboardScreen(app: app)
            .tapStoreFinder()
            .tapNewComics()
            .verifyNewComicsView()
    }

    func test_tappingCurrentListViewLoadsCorrectView() throws {
        DashboardScreen(app: app)
            .tapCurrentList()
            .verifyCurrentListView()
    }
}
