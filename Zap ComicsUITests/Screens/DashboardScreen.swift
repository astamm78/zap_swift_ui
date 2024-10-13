//
//  DashboardScreen.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/13/24.
//

import XCTest

struct DashboardScreen: Screen {
    let app: XCUIApplication

    @discardableResult func verifyDashboardScreen() -> Self {
        let dashboardNavLogo = self.app.images[TestingIdentifiers.Dashboard.navLogoImage]
        XCTAssertTrue(dashboardNavLogo.waitForExistence(timeout: 2))
        return self
    }
}
