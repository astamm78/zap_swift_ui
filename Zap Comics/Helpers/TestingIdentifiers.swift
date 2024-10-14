//
//  TestingIdentifiers.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/12/24.
//

import Foundation

enum TestingIdentifiers {
    enum Dashboard {
        public static var navLogoImage = "navLogoImage"
        public static var newComicsTabButton = "New Comics"
        public static var currentListTabButton = "Current List"
        public static var pastListsTabButton = "Recent Lists"
        public static var storeFinderTabButton = "Store Finder"
        public static var menuButton = "menuButton"
        public static var logoutButton = "logoutButton"
    }

    enum LoginView {
        public static var loginUsernameTextField = "loginUsernameTextField"
        public static var loginPasswordTextField = "loginPasswordTextField"
        public static var loginButton = "loginButton"
        public static var registrationLink = "registrationLink"
    }

    enum RegistrationView {
        public static var registerUsernameTextField = "registerUsernameTextField"
        public static var registerPasswordTextField = "registerPasswordTextField"
        public static var registerButton = "registerButton"
    }

    enum NewComicsView {
        public static var newComicsView = "newComicsView"
    }

    enum CurrentListView {
        public static var currentListView = "currentListView"
    }
}
