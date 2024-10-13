//
//  Zap_ComicsApp.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI

@main
struct Zap_ComicsApp: App {
    init() {
        configureForUITesting()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentViewModel())
        }
    }
}

extension Zap_ComicsApp {
    fileprivate func configureForUITesting() {
        let args = CommandLine.arguments

        if args.contains(UITestArguments.loggedOut) {
            User.clearCurrentUser()
        }
    }
}
