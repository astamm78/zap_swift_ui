//
//  Zap_ComicsApp.swift
//  Zap Comics
//
//  Created by Andrew Stamm on 10/5/24.
//

import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Zap_ComicsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        configureForUITesting()
        
        if let _ = User.current {
            Task {
                await Application.bootstrap()                
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentViewModel.shared)
        }
    }
}

extension Zap_ComicsApp {
    fileprivate func configureForUITesting() {
        let args = CommandLine.arguments

        if args.contains(UITestArguments.loggedOut) {
            User.clearCurrent()
        }

        if args.contains(UITestArguments.loggedIn) {
            guard let _ = User.current else {
                User.preview.save(completion: {_ in })
                return
            }
        }
    }
}
