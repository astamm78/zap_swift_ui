//
//  DashboardScreen.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/13/24.
//

import XCTest

struct DashboardScreen: Screen {
    let app: XCUIApplication

    func tapMenu() -> Self {
        let button = app.images[TestingIdentifiers.Dashboard.menuButton]
        button.tap()
        return self
    }

    func tapLogOut() -> LoginScreen {
        let button = app.buttons[TestingIdentifiers.Dashboard.logoutButton]
        button.tap()
        return LoginScreen(app: app)
    }

    func tapNewComics() -> Self {
        let button = app.buttons[TestingIdentifiers.Dashboard.newComicsTabButton]
        button.tap()
        return self
    }

    func tapCurrentList() -> Self {
        let button = app.buttons[TestingIdentifiers.Dashboard.currentListTabButton]
        button.tap()
        return self
    }

    func tapPastLists() -> Self {
        let button = app.buttons[TestingIdentifiers.Dashboard.pastListsTabButton]
        button.tap()
        return self
    }

    func tapStoreFinder() -> Self {
        let button = app.buttons[TestingIdentifiers.Dashboard.storeFinderTabButton]
        button.tap()
        return self
    }

    @discardableResult func verifyNewComicsView() -> Self {
        let view = app.scrollViews[TestingIdentifiers.NewComicsView.newComicsView]
        XCTAssertTrue(view.waitForExistence(timeout: 5))
        return self
    }

    @discardableResult func verifyCurrentListView() -> Self {
        let view = app.scrollViews[TestingIdentifiers.CurrentListView.currentListView]
        XCTAssertTrue(view.exists)
        return self
    }

    @discardableResult func verifyDashboardScreen() -> Self {
        let dashboardNavLogo = app.images[TestingIdentifiers.Dashboard.navLogoImage]
        XCTAssertTrue(dashboardNavLogo.waitForExistence(timeout: 2))
        return self
    }

    @discardableResult func verifyNewComicsTabButtonIsSelected() -> Self {
        let tab = app.otherElements[TestingIdentifiers.Dashboard.newComicsTabButton]
        XCTAssertTrue(tab.isSelected)
        return self
    }

    @discardableResult func verifyCurrentListTabButtonIsSelected() -> Self {
        let tab = app.otherElements[TestingIdentifiers.Dashboard.currentListTabButton]
        XCTAssertTrue(tab.isSelected)
        return self
    }

    @discardableResult func verifyPastListsTabButtonIsSelected() -> Self {
        let tab = app.otherElements[TestingIdentifiers.Dashboard.pastListsTabButton]
        XCTAssertTrue(tab.isSelected)
        return self
    }

    @discardableResult func verifyStoreFinderTabButtonIsSelected() -> Self {
        let tab = app.otherElements[TestingIdentifiers.Dashboard.storeFinderTabButton]
        XCTAssertTrue(tab.isSelected)
        return self
    }
}
