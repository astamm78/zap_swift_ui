//
//  Login_XCTest.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/12/24.
//

import XCTest
@testable import Zap_Comics

final class Login_XCTest: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append(UITestArguments.loggedOut)
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_loginLoadsForLoggedOutUser() throws {
        LoginScreen(app: app)
            .verifyLoginScreen()
    }

    func test_registrationFlow() throws {
        LoginScreen(app: app)
            .tapRegister()
            .verifyRegistrationScreen()
    }

    func test_loginFlow() throws {
        LoginScreen(app: app)
            .type(login: "testuser")
            .type(password: "password")
            .tapSignIn()
            .verifyDashboardScreen()
    }
}
