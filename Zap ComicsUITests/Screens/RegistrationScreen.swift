//
//  RegistrationScreen.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/13/24.
//

import XCTest

struct RegistrationScreen: Screen {
    let app: XCUIApplication

    @discardableResult func verifyRegistrationScreen() -> Self {
        let usernameInput = app.textFields[TestingIdentifiers.RegistrationView.registerUsernameTextField]
        XCTAssertTrue(usernameInput.waitForExistence(timeout: 2))
        return self
    }
}
