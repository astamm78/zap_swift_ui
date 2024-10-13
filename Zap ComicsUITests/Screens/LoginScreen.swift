//
//  LoginScreen.swift
//  Zap ComicsUITests
//
//  Created by Andrew Stamm on 10/13/24.
//

import XCTest

struct LoginScreen: Screen {
    let app: XCUIApplication

    func type(login: String) -> Self {
        let usernameInput = app.textFields[TestingIdentifiers.LoginView.loginUsernameTextField]
        usernameInput.tap()
        usernameInput.typeText(login)
        return self
    }

    func type(password: String) -> Self {
        let passwordInput = app.secureTextFields[TestingIdentifiers.LoginView.loginPasswordTextField]
        passwordInput.tap()
        passwordInput.typeText(password)
        return self
    }

    func tapSignIn() -> DashboardScreen {
        app.buttons[TestingIdentifiers.LoginView.loginButton].tap()
        return DashboardScreen(app: app)
    }

    func tapRegister() -> RegistrationScreen {
        app.buttons[TestingIdentifiers.LoginView.registrationLink].tap()
        return RegistrationScreen(app: app)
    }

    @discardableResult func verifyLoginScreen() -> Self {
        let usernameInput = app.textFields[TestingIdentifiers.LoginView.loginUsernameTextField]
        XCTAssertTrue(usernameInput.waitForExistence(timeout: 2))
        return self
    }
}
